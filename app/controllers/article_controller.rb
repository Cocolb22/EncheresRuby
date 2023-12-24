class ArticleController < ApplicationController

  def create
    @article = Article.new(article_params)
    @user = current_user
    @article.user_id = user.id
    @article.categorie_id = params[:categorie_id]
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end


  private

  def article_params
    params.require(:article).permit(:name, :description, :first_price, :start_date, :end_date, :categorie_id, :image)
  end
end
