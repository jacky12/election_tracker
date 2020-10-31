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

ActiveRecord::Schema.define(version: 2020_09_15_210554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "city", primary_key: "city_id", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "search_area_id"
  end

  create_table "counties", force: :cascade do |t|
    t.string "name"
    t.integer "dem"
    t.integer "gop"
    t.bigint "state_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "precincts_reporting"
    t.integer "total_precincts"
    t.float "percentage_precincts_reporting"
    t.index ["state_id"], name: "index_counties_on_state_id"
  end

  create_table "neighborhood", primary_key: "neighborhood_id", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "search_area_id"
  end

  create_table "queue", id: false, force: :cascade do |t|
    t.string "name", limit: 40, null: false
    t.float "n_lat"
    t.float "s_lat"
    t.float "e_lng"
    t.float "w_lng"
    t.boolean "fully_scraped", default: false
  end

# Could not dump table "room" because of following StandardError
#   Unknown type 'geometry' for column 'location'

# Could not dump table "room_copy" because of following StandardError
#   Unknown type 'geometry' for column 'location'

  create_table "schema_version", primary_key: "version", id: :decimal, precision: 5, scale: 2, force: :cascade do |t|
  end

  create_table "search_area", primary_key: "search_area_id", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, default: "UNKNOWN"
    t.string "abbreviation", limit: 10
    t.float "bb_n_lat"
    t.float "bb_e_lng"
    t.float "bb_s_lat"
    t.float "bb_w_lng"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
  end

  add_foreign_key "counties", "states"
end
