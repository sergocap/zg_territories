# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170215041214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.string   "ancestry"
    t.integer  "ancestry_depth", default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["ancestry"], name: "index_categories_on_ancestry", using: :btree
  end

  create_table "category_properties", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "property_id"
    t.integer  "row_order"
    t.boolean  "necessarily",    default: false
    t.boolean  "show_on_public", default: true
    t.string   "show_as",        default: "check_boxes"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["category_id"], name: "index_category_properties_on_category_id", using: :btree
    t.index ["property_id"], name: "index_category_properties_on_property_id", using: :btree
  end

  create_table "hierarch_list_items", force: :cascade do |t|
    t.string   "title"
    t.string   "ancestry"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["property_id"], name: "index_hierarch_list_items_on_property_id", using: :btree
  end

  create_table "list_item_values", force: :cascade do |t|
    t.integer  "heirarch_list_item_id"
    t.integer  "list_item_id"
    t.integer  "value_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["heirarch_list_item_id"], name: "index_list_item_values_on_heirarch_list_item_id", using: :btree
    t.index ["list_item_id"], name: "index_list_item_values_on_list_item_id", using: :btree
    t.index ["value_id"], name: "index_list_item_values_on_value_id", using: :btree
  end

  create_table "list_items", force: :cascade do |t|
    t.string   "title"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["property_id"], name: "index_list_items_on_property_id", using: :btree
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "user_id"
    t.string   "role"
    t.string   "context_type"
    t.integer  "context_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "role", "context_id", "context_type"], name: "by_user_and_role_and_context", using: :btree
  end

  create_table "properties", force: :cascade do |t|
    t.string   "kind"
    t.string   "title"
    t.integer  "category_id"
    t.string   "show_on_filter_as"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "values", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "property_id"
    t.integer  "list_item_id"
    t.integer  "hierarch_list_item_id"
    t.string   "string_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.boolean  "boolean_value"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["hierarch_list_item_id"], name: "index_values_on_hierarch_list_item_id", using: :btree
    t.index ["list_item_id"], name: "index_values_on_list_item_id", using: :btree
    t.index ["organization_id"], name: "index_values_on_organization_id", using: :btree
    t.index ["property_id"], name: "index_values_on_property_id", using: :btree
  end

end
