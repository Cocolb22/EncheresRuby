# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_03_162229) do
  create_table "article_vendus", force: :cascade do |t|
    t.string "nomArticle"
    t.text "description"
    t.date "dateDebutEncheres"
    t.date "dateFinEncheres"
    t.integer "prixInitial"
    t.integer "prixVente"
    t.integer "user_id"
    t.integer "categorie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categorie_id"], name: "index_article_vendus_on_categorie_id"
    t.index ["user_id"], name: "index_article_vendus_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "noCategorie"
    t.string "libelle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encheres", force: :cascade do |t|
    t.integer "user_id"
    t.integer "article_vendu_id"
    t.datetime "dateEnchere"
    t.integer "montantEnchere"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_vendu_id"], name: "index_encheres_on_article_vendu_id"
    t.index ["user_id"], name: "index_encheres_on_user_id"
  end

  create_table "retraits", force: :cascade do |t|
    t.integer "article_vendu_id"
    t.string "rue"
    t.string "codePostal"
    t.string "ville"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_vendu_id"], name: "index_retraits_on_article_vendu_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "pseudo"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_vendus", "categories", column: "categorie_id"
  add_foreign_key "article_vendus", "users"
  add_foreign_key "encheres", "article_vendus"
  add_foreign_key "encheres", "users"
  add_foreign_key "retraits", "article_vendus"
end
