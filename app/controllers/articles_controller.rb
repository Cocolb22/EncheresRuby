# frozen_string_literal: true

class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.status = 'Créée'
    if @article.save
      flash[:success] = 'Votre enchère a bien été créée'
      redirect_to root_path
    else
      flash[:danger] = "Votre enchère n'a pas été créée"
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @user = current_user
    @article_user = User.find(@article.user_id)
    @bids = @article.bids.order(bid_price: :desc)
    @highest_bid = @article.get_highest_bid
    @bid = Bid.new
    @winner = @article.get_winner
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
      flash[:message] = 'Votre enchère a bien été modifiée'
    else
      render :edit
    end
  end

  def destroy
    return unless @article.status == 'Créée'

    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:name, :description, :first_price, :start_date, :end_date, :category)
  end

  def open_auction
    @article = Article.find(params[:id])
    if @article.status != 'Ouverte'
      @article.status.update('Ouverte')
      @article.start_date.update(DateTime.now)
      @article.save
      redirect_to article_path(@article)
    else
      redirect_to article_path(@article)
      flash[:warning] = 'Votre enchère est déjà ouverte'
    end
  end
end
