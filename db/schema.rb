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

ActiveRecord::Schema[7.0].define(version: 2023_09_10_201134) do
  create_table "clients", force: :cascade do |t|
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "frames", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "status"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lenses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "lens_type"
    t.integer "prescription_type"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "client_id"
    t.integer "frame_id"
    t.integer "lens_id"
    t.float "price"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["frame_id"], name: "index_orders_on_frame_id"
    t.index ["lens_id"], name: "index_orders_on_lens_id"
  end

  create_table "pricings", force: :cascade do |t|
    t.float "usd"
    t.float "gbp"
    t.float "eur"
    t.float "jod"
    t.float "jpy"
    t.bigint "priceable_id"
    t.string "priceable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priceable_id", "priceable_type"], name: "index_pricings_on_priceable_id_and_priceable_type"
  end

end
