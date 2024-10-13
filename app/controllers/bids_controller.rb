# frozen_string_literal: true

class BidsController < ApplicationController
  def create
  @bid = Bid.new(bid_params)
  @article = Article.find(params[:article_id])
  @bid.article = @article
  @bid.user = current_user

  if @bid.bid_price.nil?
    flash[:danger] = t('bid.price_required')
    redirect_to article_path(@article)
    return
  end

  if @article.user_id = @bid.user.id
    flash[:danger] = t('bid.creator_cant_bid')
    redirect_to article_path(@article)
    return
  end

  ActiveRecord::Base.transaction do
    if @bid.user.credit < @bid.bid_price
      flash[:danger] = t('bid.not_enough')
      redirect_to article_path(@article)
      return
    end

    if @article.bids.any? && @article.bids.order(bid_price: :desc).first.user_id == current_user.id
      flash[:danger] = t('bid.already_leading')
      redirect_to article_path(@article)
      return
    end

    last_bid = @article.bids.order(bid_price: :desc).first
    second_highest_bid = @article.bids.order(bid_price: :desc).second

    if last_bid
      last_bid.user.credit += last_bid.bid_price
      last_bid.user.save!
    end

    if second_highest_bid
      second_highest_bid.user.credit -= second_highest_bid.bid_price
      second_highest_bid.user.save!
    end

    if @bid.save
      @bid.user.credit -= @bid.bid_price
      @bid.user.save!
      flash[:success] = t('bid.created')
    else
      flash[:danger] = @bid.errors.full_messages.join(', ')
    end
  end

  redirect_to article_path(@article)
  end


  private

  def bid_params
    params.require(:bid).permit(:bid_price)
  end
end
