# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.integer :first_price
      t.integer :end_price
      t.string :image
      t.string :category
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
