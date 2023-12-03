class CreateEncheres < ActiveRecord::Migration[7.0]
  def change
    create_table :encheres do |t|
      t.references :user, foreign_key: true
      t.references :article_vendu, foreign_key: true
      t.datetime :dateEnchere
      t.integer :montantEnchere
      t.timestamps
    end
  end
end
