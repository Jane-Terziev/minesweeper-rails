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

ActiveRecord::Schema[7.0].define(version: 2022_08_11_142608) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_matrices", primary_key: "board_id", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.text "matrix", array: true
    t.index ["board_id"], name: "index_board_matrices_on_board_id"
  end

  create_table "boards", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.integer "width", null: false
    t.integer "height", null: false
    t.integer "bombs", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "board_matrices", "boards", on_delete: :cascade
end
