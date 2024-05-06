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
      flash[:success] = t('article.created')
      redirect_to root_path
    else
      flash[:danger] = t('article.not_created')
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
    if (DateTime.now.strftime('%d/%m/%Y %H:%M') > @article.start_date.strftime('%d/%m/%Y %H:%M'))
      redirect_to article_path(@article)
      flash[:danger] =  t('article.cant_update_on_going')
    elsif @article.update(article_params)
      redirect_to article_path(@article)
      flash[:message] = t('article.updated')
    else
      render :edit
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    if (DateTime.now.strftime('%d/%m/%Y %H:%M') < @article.start_date.strftime('%d/%m/%Y %H:%M'))
      @article.destroy
      redirect_to root_path
    else
      flash[:danger] = t('article.cant_delete_on_going')
      redirect_to article_path(@article)
    end
  end

  private

  def article_params
    params.require(:article).permit(:name, :description, :first_price, :start_date, :end_date, :category)
  end

  def open_auction
    @articles = Article.all
    @articles.each do |article|
      if article.start_date < DateTime.now
        article.status.update('En cours')
        @article.save
        redirect_to article_path(@article)
      end
    end
  end

  def close_auction
    @articles = Article.all
    @articles.each do |article|
      if article.end_date < DateTime.now
        article.status.update('Fermée')
        article.save
      end
    end 
  end
end
