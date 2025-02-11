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

ActiveRecord::Schema[8.0].define(version: 2025_02_11_030959) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "kaji_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "kaji_id", null: false
    t.datetime "performed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kaji_id"], name: "index_kaji_records_on_kaji_id"
    t.index ["user_id"], name: "index_kaji_records_on_user_id"
  end

  create_table "kajis", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "email"
    t.string "photo_url"
    t.integer "total_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "kaji_records", "kajis"
  add_foreign_key "kaji_records", "users"
end
