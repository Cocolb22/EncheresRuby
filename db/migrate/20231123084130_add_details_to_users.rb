# frozen_string_literal: true

class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :street, :string
    add_column :users, :zip_code, :string
    add_column :users, :city, :string
    add_column :users, :credit, :integer
    add_column :users, :administrateur, :boolean
  end
end
