class CreateArticleVendus < ActiveRecord::Migration[7.0]
  def change
    create_table :article_vendus do |t|
      t.string :nomArticle
      t.text :description
      t.date :dateDebutEncheres
      t.date :dateFinEncheres
      t.integer :prixInitial
      t.integer :prixVente
      t.references :user, foreign_key: true
      t.references :categorie, foreign_key: true
      t.timestamps
    end
  end
end
