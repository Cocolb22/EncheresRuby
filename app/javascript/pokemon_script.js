document.addEventListener('DOMContentLoaded', function() {
    const pokemons = JSON.parse(document.body.dataset.pokemons).slice(0, 152);

    const pokemonNameInput = document.getElementById('pokemon-name-input'); 
    const categoryInput = document.getElementById('pokemon-category-input');

    pokemonNameInput.addEventListener('input', function() {
        const pokemonName = pokemonNameInput.value.toLowerCase();
        const pokemon = pokemons.find(pokemon => pokemon.name.fr.toLowerCase() === pokemonName);

        if (pokemon) {
            const pokemonType = pokemon.types[0].name;
            categoryInput.value = pokemonType;
        } else {
            categoryInput.value = '';
        }
    });
});
