# frozen_string_literal: true

class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true
      t.datetime :bid_date
      t.integer :bid_price
      t.timestamps
    end
  end
end
