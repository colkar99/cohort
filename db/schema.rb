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

ActiveRecord::Schema.define(version: 2018_11_15_052259) do

  create_table "module_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "program_types", force: :cascade do |t|
    t.string "program_type_title"
    t.text "program_type_description"
    t.string "program_type_duration"
    t.string "program_type_logo"
    t.string "program_type_main_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isDelete"
    t.integer "deleted_by"
    t.string "deleted_date"
    t.integer "created_by"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer "module_type_id"
    t.integer "role_id"
    t.boolean "create_rule", default: false
    t.boolean "edit_rule", default: false
    t.boolean "update_rule", default: false
    t.boolean "delete_rule", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["module_type_id"], name: "index_role_permissions_on_module_type_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.integer "module_type_id"
    t.boolean "create_rule", default: false
    t.boolean "update_rule", default: false
    t.boolean "delete_rule", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isDelete", default: false
    t.integer "created_by"
    t.integer "deleted_by"
    t.index ["module_type_id"], name: "index_user_roles_on_module_type_id"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "email"
    t.string "password_digest"
    t.string "access_token"
    t.string "user_main_image"
    t.string "credentials"
    t.string "commitment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_date"
    t.integer "created_by"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state_province_region"
    t.string "zip_pincode_postalcode"
    t.string "country"
    t.string "geo_location"
  end

end
