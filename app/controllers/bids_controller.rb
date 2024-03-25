class BidsController < ApplicationController
  def create
    @bid = Bid.new(bid_params)
    @article = Article.find(params[:article_id])
    if @article.status != 'Ouverte'
      @bid.article = @article
      @bid.user = current_user

      if @bid.save
        redirect_to article_path(@article)
        flash[:success] = t('bid.created')
      else
        redirect_to article_path(@article)
        flash[:danger] = t('bid.not_created') + " #{@article.get_highest_bid}"
      end
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:bid_price)
  end
end
