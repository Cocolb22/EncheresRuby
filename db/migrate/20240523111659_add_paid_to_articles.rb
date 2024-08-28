# frozen_string_literal: true

class AddPaidToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :paid, :boolean, default: false
  end
end
