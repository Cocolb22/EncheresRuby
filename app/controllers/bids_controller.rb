# frozen_string_literal: true

class BidsController < ApplicationController
  def create
    @bid = Bid.new(bid_params)
    @article = Article.find(params[:article_id])

    if @article.user_id == current_user.id && @article.bids.count.zero?
      flash[:danger] = t('bid.cant_be_first_bidder')
      redirect_to article_path(@article)
      return
    end

    if @article.start_date.strftime('%d/%m/%Y %H:%M') < DateTime.now.strftime('%d/%m/%Y %H:%M')
      @bid.article = @article
      @bid.user = current_user

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

        @bid.save!

        last_bid = @article.bids.order(bid_price: :desc).first
        if last_bid
          last_bid.user.credit -= last_bid.bid_price
          last_bid.user.save!
        end

        second_highest_bid = @article.bids.order(bid_price: :desc).second
        if second_highest_bid
          second_highest_bid.user.credit += second_highest_bid.bid_price
          second_highest_bid.user.save!
        end

        flash[:success] = t('bid.created')
      end

    else
      flash[:danger] = t('bid.article_not_active')
    end
    redirect_to article_path(@article)
  end

  private

  def bid_params
    params.require(:bid).permit(:bid_price)
  end
end
