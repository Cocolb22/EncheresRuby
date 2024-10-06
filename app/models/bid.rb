# frozen_string_literal: true

class Bid < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :bid_price, presence: true
  validate :new_bid_cant_be_lower_than_highest_bid

  def new_bid_cant_be_lower_than_highest_bid
    return unless bid_price.present? && article.present?

    highest_bid = article.get_highest_bid || article.starting_price

    if bid_price <= highest_bid
      errors.add(:base, I18n.t('bid.cant_be_lower_than_highest_price'))
    end
  end

  def handle_credit_reallocation
    leading_bid = article.bids.order(bid_price: :desc).first
    return unless leading_bid && leading_bid.user != user

    current_leading_user = leading_bid.user

    user.credit -= bid_price

    current_leading_user.credit += leading_bid.bid_price

    user.save!
    current_leading_user.save!
  end
end
