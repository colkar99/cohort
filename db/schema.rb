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

ActiveRecord::Schema.define(version: 2018_11_21_092711) do

  create_table "module_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "program_locations", force: :cascade do |t|
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state_province_region"
    t.string "zip_pincode_postalcode"
    t.string "country"
    t.string "geo_location"
    t.integer "created_by"
    t.boolean "isDelete", default: false
    t.string "deleted_by"
    t.string "delete_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "program_reg_ques_responses", force: :cascade do |t|
    t.integer "program_reg_question_id"
    t.integer "startup_profile_id"
    t.text "response"
    t.integer "response_id"
    t.integer "reviewer_rating"
    t.text "reviewer_feedback"
    t.integer "program_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_location_id"], name: "index_program_reg_ques_responses_on_program_location_id"
    t.index ["program_reg_question_id"], name: "index_program_reg_ques_responses_on_program_reg_question_id"
    t.index ["startup_profile_id"], name: "index_program_reg_ques_responses_on_startup_profile_id"
  end

  create_table "program_registration_questions", force: :cascade do |t|
    t.string "title"
    t.text "question"
    t.text "description"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.integer "created_by"
    t.string "deleted_date"
    t.text "placeholder"
    t.integer "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "program_location_id"
    t.index ["program_id"], name: "index_program_registration_questions_on_program_id"
    t.index ["program_location_id"], name: "index_program_registration_questions_on_program_location_id"
  end

  create_table "program_statuses", force: :cascade do |t|
    t.string "status"
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

  create_table "programs", force: :cascade do |t|
    t.integer "program_type_id"
    t.string "title"
    t.text "description"
    t.string "start_date"
    t.string "end_date"
    t.integer "program_admin_id"
    t.integer "seat_size"
    t.string "industry"
    t.string "main_image"
    t.string "logo_image"
    t.string "duration"
    t.string "application_start_date"
    t.string "application_end_date"
    t.integer "created_by"
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.string "deleted_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ProgramLocation_id"
    t.boolean "isActive", default: true
    t.index ["ProgramLocation_id"], name: "index_programs_on_ProgramLocation_id"
    t.index ["program_type_id"], name: "index_programs_on_program_type_id"
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

  create_table "social_media", force: :cascade do |t|
    t.string "name"
    t.boolean "isActive", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_media_links", force: :cascade do |t|
    t.integer "social_media_id"
    t.integer "startup_profile_id"
    t.string "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["social_media_id"], name: "index_social_media_links_on_social_media_id"
    t.index ["startup_profile_id"], name: "index_social_media_links_on_startup_profile_id"
  end

  create_table "startup_profile_questions", force: :cascade do |t|
    t.string "title"
    t.text "question"
    t.text "description"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.integer "created_by"
    t.string "deleted_date"
    t.text "placeholder"
    t.integer "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "program_location_id"
    t.index ["program_id"], name: "index_startup_profile_questions_on_program_id"
    t.index ["program_location_id"], name: "index_startup_profile_questions_on_program_location_id"
  end

  create_table "startup_profiles", force: :cascade do |t|
    t.string "startup_name"
    t.string "password_digest"
    t.string "email"
    t.string "main_image"
    t.string "thumb_image"
    t.string "logo_image"
    t.string "founded_date"
    t.text "description"
    t.boolean "incorporated"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state_province_region"
    t.string "zip_pincode_postalcode"
    t.string "country"
    t.string "geo_location"
    t.integer "created_by"
    t.boolean "isDelete", default: false
    t.string "deleted_by"
    t.string "delete_at"
    t.integer "team_size"
    t.string "current_stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "startup_question_responses", force: :cascade do |t|
    t.integer "startup_question_id"
    t.integer "startup_profile_id"
    t.text "response"
    t.integer "program_id"
    t.integer "reviewer_rating"
    t.text "reviewer_feedback"
    t.integer "program_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_startup_question_responses_on_program_id"
    t.index ["program_location_id"], name: "index_startup_question_responses_on_program_location_id"
    t.index ["startup_profile_id"], name: "index_startup_question_responses_on_startup_profile_id"
    t.index ["startup_question_id"], name: "index_startup_question_responses_on_startup_question_id"
  end

  create_table "startup_registrations", force: :cascade do |t|
    t.string "startup_name"
    t.string "founded_date"
    t.string "website_url"
    t.string "entity_type"
    t.integer "program_id"
    t.integer "startup_profile_id"
    t.integer "program_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_startup_registrations_on_program_id"
    t.index ["program_status_id"], name: "index_startup_registrations_on_program_status_id"
    t.index ["startup_profile_id"], name: "index_startup_registrations_on_startup_profile_id"
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
