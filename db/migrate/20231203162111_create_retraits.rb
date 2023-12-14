# frozen_string_literal: true

class CreateRetraits < ActiveRecord::Migration[7.0]
  def change
    create_table :retraits do |t|
      t.references :article_vendu, foreign_key: true
      t.string :rue
      t.string :codePostal
      t.string :ville
      t.timestamps
    end
  end
end
