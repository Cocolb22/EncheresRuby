# frozen_string_literal: true

class CreateWithdraws < ActiveRecord::Migration[7.0]
  def change
    create_table :withdraws do |t|
      t.references :article, foreign_key: true
      t.string :street
      t.string :zip_code
      t.string :city
      t.timestamps
    end
  end
end
