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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "city", primary_key: "city_id", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "search_area_id"
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

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
  end

  create_table "survey", primary_key: "survey_id", id: :serial, force: :cascade do |t|
    t.date "survey_date", default: -> { "('now'::text)::date" }
    t.string "survey_description", limit: 255
    t.integer "search_area_id"
    t.string "comment", limit: 255
    t.string "survey_method", limit: 20, default: "neighborhood"
    t.integer "status", limit: 2
  end

  create_table "survey_progress_log", primary_key: "page_id", id: :integer, default: -> { "nextval('survey_search_page_page_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "survey_id", null: false
    t.string "room_type", limit: 255, null: false
    t.integer "neighborhood_id"
    t.integer "page_number", null: false
    t.integer "guests", null: false
    t.integer "has_rooms", limit: 2
    t.string "zoomstack", limit: 255
  end

  create_table "survey_progress_log_bb", primary_key: "survey_id", id: :integer, default: nil, force: :cascade do |t|
    t.string "room_type", limit: 255
    t.integer "guests"
    t.float "price_min"
    t.float "price_max"
    t.string "quadtree_node", limit: 1024
    t.datetime "last_modified", default: -> { "now()" }
    t.text "median_node"
  end

  create_table "zipcode", primary_key: "zipcode", id: :string, limit: 10, force: :cascade do |t|
    t.integer "search_area_id"
  end

  create_table "zipcode_us", primary_key: "zip", id: :integer, default: nil, force: :cascade do |t|
    t.string "type", limit: 20
    t.string "primary_city", limit: 50
    t.string "acceptable_cities", limit: 300
    t.string "state", limit: 3
    t.string "county", limit: 50
    t.string "timezone", limit: 50
    t.string "area_code", limit: 50
    t.decimal "latitude", precision: 6, scale: 2
    t.decimal "longitude", precision: 6, scale: 2
    t.string "world_region", limit: 10
    t.string "country", limit: 20
    t.integer "decommissioned"
    t.integer "estimated_population"
    t.string "notes", limit: 255
  end

  add_foreign_key "zipcode", "search_area", primary_key: "search_area_id", name: "zipcode_search_area_id_fkey"
end
