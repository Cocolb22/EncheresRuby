document.addEventListener("DOMContentLoaded", function() {
    const checkboxes = document.querySelectorAll('.form-check-input');
    const articlesContainer = document.getElementById('articles-list');
    const articles = Array.from(document.querySelectorAll('.article'));
    const searchInput = document.getElementById('searchInput');

    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', filterArticles);
    });

    searchInput.addEventListener('input', filterByName);

    function filterArticles() {
        const filters = {
            NotStart: document.getElementById('filterNotStart').checked,
            OngGoing: document.getElementById('filterOngGoing').checked,
            Ended: document.getElementById('filterEnded').checked,
            Won: document.getElementById('filterWon').checked,
            Bet: document.getElementById('filterBet').checked,
            Created: document.getElementById('filterCreated').checked
        };

        const now = new Date();
        const currentUserElement = document.querySelector('[data-current-user-id]');
        const currentUserId = currentUserElement ? currentUserElement.getAttribute('data-current-user-id') : null;

        const noFilterApplied = !Object.values(filters).some(value => value);

        if (noFilterApplied) {
            articles.forEach(article => {
                article.closest('.col-md-4').style.display = 'block';
            });

            const noArticlesMessage = articlesContainer.querySelector('.no-articles-message');
            if (noArticlesMessage) {
                noArticlesMessage.remove();
            }
            return;
        }

        const filteredArticles = articles.filter(article => {
            const startDate = new Date(article.getAttribute('data-start-date'));
            const endDate = new Date(article.getAttribute('data-end-date'));
            const userId = article.getAttribute('data-user-id');
            const bids = JSON.parse(article.getAttribute('data-bids'));
            const winningBid = bids.length > 0 ? bids.sort((a, b) => b.bid_price - a.bid_price)[0] : null;

            let isVisible = false;

            if (filters.NotStart && startDate > now) isVisible = true;
            if (filters.OngGoing && startDate <= now && endDate >= now) isVisible = true;
            if (filters.Ended && endDate < now) isVisible = true;
            if (filters.Won && endDate < now && winningBid && winningBid.user_id == currentUserId) isVisible = true;
            if (filters.Bet && bids.some(bid => bid.user_id == currentUserId)) isVisible = true;
            if (filters.Created && userId == currentUserId) isVisible = true;

            return isVisible;
        });

        articles.forEach(article => {
            if (filteredArticles.includes(article)) {
                article.closest('.col-md-4').style.display = 'block';
            } else {
                article.closest('.col-md-4').style.display = 'none';
            }
        });

        const noArticlesMessage = articlesContainer.querySelector('.no-articles-message');
        if (noArticlesMessage) {
            noArticlesMessage.remove();
        }

        if (filteredArticles.length === 0) {
            const message = document.createElement('p');
            message.classList.add('no-articles-message');
            message.textContent = 'Aucun article correspondant aux filtres.';
            articlesContainer.appendChild(message);
        }
    }

    function filterByName() {
      const searchQuery = searchInput.value.toLowerCase();

      articles.forEach(article => {
          const articleName = article.getAttribute('data-name');
          if (articleName.includes(searchQuery)) {
              article.closest('.col-md-4').style.display = 'block';
          } else {
              article.closest('.col-md-4').style.display = 'none';
          }
      });

      const noArticlesMessage = articlesContainer.querySelector('.no-articles-message');
      if (noArticlesMessage) {
          noArticlesMessage.remove();
      }

      const visibleArticles = articles.filter(article => article.closest('.col-md-4').style.display !== 'none');
      if (visibleArticles.length === 0) {
          const message = document.createElement('p');
          message.classList.add('no-articles-message');
          message.textContent = 'Aucun article correspondant aux filtres.';
          articlesContainer.appendChild(message);
      }
  }
});
