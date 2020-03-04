# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_03_155034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "password_reset_requests", force: :cascade do |t|
    t.string "email", limit: 100
    t.string "code", limit: 256
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "used_at"
    t.index ["code"], name: "index_password_reset_requests_on_code"
    t.index ["email"], name: "index_password_reset_requests_on_email"
  end

  create_table "records", force: :cascade do |t|
    t.integer "amount"
    t.string "notes"
    t.integer "category", limit: 2, null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_records_on_discarded_at"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "user_id", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_taggings_on_discarded_at"
    t.index ["record_id"], name: "index_taggings_on_record_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["user_id"], name: "index_taggings_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_tags_on_discarded_at"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", limit: 100
    t.string "password_digest"
  end

end
