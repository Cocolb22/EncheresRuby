class Bid < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :bid_price, presence: true
  validate :new_bid_cant_be_lower_than_highest_bid

  def new_bid_cant_be_lower_than_highest_bid
    if bid_price.present? && bid_price < article.get_highest_bid
      errors.add(:bid_price, "cette enchère est inférieure à la plus haute enchère")
    end

  end
end
