class BidsController < ApplicationController
  def create
    @bid = Bid.new(bid_params)
    @article = Article.find(params[:article_id])
    @bid.article = @article
    @bid.user = current_user
    
    respond_to do |format|
      if @bid.save
        format.html { redirect_to @article, notice: 'Bid was successfully created.' }
        format.json { render json: { success: true } }
      else
        format.html { render 'articles/show' }
        format.json { render json: { errors: @bid.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:bid_price)
  end
end
