# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.integer :noCategorie
      t.string :libelle
      t.timestamps
    end
  end
end
