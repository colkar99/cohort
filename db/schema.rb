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

ActiveRecord::Schema.define(version: 2019_02_26_062513) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "placeholder"
    t.integer "order"
    t.integer "created_by"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_responses", force: :cascade do |t|
    t.text "startup_response"
    t.integer "startup_profile_id"
    t.integer "activity_id"
    t.integer "admin_rating"
    t.text "admin_feedback"
    t.integer "mentor_rating"
    t.text "mentor_feedback"
    t.integer "created_by"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_id"
    t.integer "mentor_id"
    t.integer "program_id"
    t.string "target_date"
    t.boolean "startup_responsed", default: false
    t.integer "course_id"
    t.boolean "admin_responsed", default: false
    t.boolean "mentor_responsed", default: false
    t.index ["activity_id"], name: "index_activity_responses_on_activity_id"
    t.index ["course_id"], name: "index_activity_responses_on_course_id"
    t.index ["program_id"], name: "index_activity_responses_on_program_id"
    t.index ["startup_profile_id"], name: "index_activity_responses_on_startup_profile_id"
  end

  create_table "additional_contract_informations", force: :cascade do |t|
    t.text "purpose_of_contract"
    t.text "contract_termination"
    t.text "contract_terms_condition"
    t.text "authorization"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_ques_responses", force: :cascade do |t|
    t.integer "application_question_id"
    t.text "response"
    t.integer "reviewer_rating"
    t.text "reviewer_feedback"
    t.integer "program_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "startup_registration_id"
    t.boolean "startup_response", default: false
    t.boolean "admin_response", default: false
    t.integer "reviewed_by"
    t.index ["application_question_id"], name: "index_app_ques_responses_on_application_question_id"
    t.index ["program_location_id"], name: "index_app_ques_responses_on_program_location_id"
    t.index ["startup_registration_id"], name: "index_app_ques_responses_on_startup_registration_id"
  end

  create_table "application_questions", force: :cascade do |t|
    t.string "title"
    t.text "question"
    t.text "description"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.integer "created_by"
    t.string "deleted_date"
    t.text "placeholder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checklist_responses", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "course_id"
    t.integer "program_id"
    t.integer "startup_profile_id"
    t.text "admin_feedback"
    t.boolean "admin_responsed", default: false
    t.text "mentor_feedback"
    t.boolean "mentor_responsed", default: false
    t.boolean "is_passed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_checklist_responses_on_activity_id"
    t.index ["course_id"], name: "index_checklist_responses_on_course_id"
    t.index ["program_id"], name: "index_checklist_responses_on_program_id"
    t.index ["startup_profile_id"], name: "index_checklist_responses_on_startup_profile_id"
  end

  create_table "checklists", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "activity_id"
    t.integer "created_by"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_checklists_on_activity_id"
  end

  create_table "contract_forms", force: :cascade do |t|
    t.integer "contract_manager_id"
    t.integer "startup_registration_id"
    t.integer "program_id"
    t.integer "additional_contract_information_id"
    t.datetime "from_date"
    t.datetime "to_date"
    t.string "duration"
    t.string "p_1_name"
    t.text "p_1_address"
    t.string "p_1_phone_number"
    t.string "p_1_email"
    t.string "p_2_name"
    t.text "p_2_address"
    t.string "p_2_phone_number"
    t.string "p_2_email"
    t.string "contract_id"
    t.boolean "accept_terms_condition", default: false
    t.boolean "contract_signed", default: false
    t.datetime "signed_date"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_date"
    t.datetime "contract_send_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "manager_approval", default: false
    t.datetime "manager_approved_date"
    t.index ["additional_contract_information_id"], name: "index_contract_forms_on_additional_contract_information_id"
    t.index ["program_id"], name: "index_contract_forms_on_program_id"
    t.index ["startup_registration_id"], name: "index_contract_forms_on_startup_registration_id"
  end

  create_table "course_activity_links", force: :cascade do |t|
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.index ["activity_id"], name: "index_course_activity_links_on_activity_id"
    t.index ["course_id"], name: "index_course_activity_links_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.text "additional_description"
    t.boolean "isActive", default: true
    t.integer "deleted_by"
    t.string "deleted_at"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "current_state_forms", force: :cascade do |t|
    t.text "revenue"
    t.text "traction"
    t.text "solution_readiness"
    t.text "investment"
    t.text "team_velocity"
    t.text "partners"
    t.text "vendors"
    t.text "vendors_costs"
    t.text "experiment_testing"
    t.text "customer_segment"
    t.text "problem_validation"
    t.text "channels"
    t.text "governance"
    t.integer "startup_profile_id"
    t.integer "program_id"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reviewer_rating"
    t.string "reviewer_feedback"
    t.integer "reviewer_id"
    t.integer "total_rating"
    t.integer "startup_registration_id"
    t.index ["program_id"], name: "index_current_state_forms_on_program_id"
    t.index ["startup_profile_id"], name: "index_current_state_forms_on_startup_profile_id"
    t.index ["startup_registration_id"], name: "index_current_state_forms_on_startup_registration_id"
  end

  create_table "founding_sources", force: :cascade do |t|
    t.text "source"
    t.text "amount"
    t.text "description"
    t.datetime "date"
    t.integer "startup_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["startup_profile_id"], name: "index_founding_sources_on_startup_profile_id"
  end

  create_table "framework_course_links", force: :cascade do |t|
    t.integer "framework_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_framework_course_links_on_course_id"
    t.index ["framework_id"], name: "index_framework_course_links_on_framework_id"
  end

  create_table "frameworks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "activity_name"
    t.integer "level", default: 0
    t.string "main_image"
    t.string "thumb_image"
    t.string "url"
    t.integer "created_by"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_uploads", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "link_of_program_questions", force: :cascade do |t|
    t.integer "application_question_id"
    t.integer "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "program_location_id"
    t.index ["application_question_id"], name: "index_link_of_program_questions_on_application_question_id"
    t.index ["program_id"], name: "index_link_of_program_questions_on_program_id"
    t.index ["program_location_id"], name: "index_link_of_program_questions_on_program_location_id"
  end

  create_table "mentor_users", force: :cascade do |t|
    t.integer "user_id"
    t.string "type_name"
    t.text "title"
    t.text "company"
    t.string "linked_in_url"
    t.string "facebook_url"
    t.text "primary_expertise"
    t.text "why_mentor"
    t.text "startup_experience"
    t.text "startup_experience_level"
    t.text "expertise_expanded"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text "commitment"
    t.string "mentorship_type"
    t.text "looking_for"
    t.string "visibility"
    t.text "area_of_expertise"
    t.integer "created_by"
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.index ["user_id"], name: "index_mentor_users_on_user_id"
  end

  create_table "milestone_resource_links", force: :cascade do |t|
    t.integer "milestone_id"
    t.integer "resource_id"
    t.integer "road_map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["milestone_id"], name: "index_milestone_resource_links_on_milestone_id"
    t.index ["resource_id"], name: "index_milestone_resource_links_on_resource_id"
    t.index ["road_map_id"], name: "index_milestone_resource_links_on_road_map_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "metric"
    t.integer "road_map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "month"
    t.integer "resource_id"
    t.index ["resource_id"], name: "index_milestones_on_resource_id"
    t.index ["road_map_id"], name: "index_milestones_on_road_map_id"
  end

  create_table "module_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "new_images", force: :cascade do |t|
    t.string "name"
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

  create_table "program_statuses", force: :cascade do |t|
    t.string "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "created_by"
    t.boolean "isDelete", default: false
    t.boolean "isActive", default: true
    t.datetime "deleted_at"
    t.string "deleted_by"
    t.string "stage"
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
    t.integer "framework_id"
    t.integer "site_admin"
    t.integer "program_admin"
    t.integer "program_director"
    t.integer "application_manager"
    t.integer "contract_manager"
    t.index ["ProgramLocation_id"], name: "index_programs_on_ProgramLocation_id"
    t.index ["framework_id"], name: "index_programs_on_framework_id"
    t.index ["program_type_id"], name: "index_programs_on_program_type_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "resource_type"
    t.string "no_of_resource"
    t.string "hours_needed"
    t.string "date_needed"
    t.string "payment_mode"
    t.integer "road_map_id"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "startup_profile_id"
    t.index ["road_map_id"], name: "index_resources_on_road_map_id"
    t.index ["startup_profile_id"], name: "index_resources_on_startup_profile_id"
  end

  create_table "road_maps", force: :cascade do |t|
    t.string "goal"
    t.text "strategy"
    t.text "description"
    t.datetime "from_date"
    t.datetime "to_date"
    t.integer "reviewed_by"
    t.text "reviewer_feedback"
    t.integer "program_id"
    t.integer "startup_profile_id"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "road_map_completed", default: true
    t.index ["program_id"], name: "index_road_maps_on_program_id"
    t.index ["startup_profile_id"], name: "index_road_maps_on_startup_profile_id"
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

  create_table "role_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.integer "created_by"
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_role_users_on_role_id"
    t.index ["user_id"], name: "index_role_users_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isActive", default: true
    t.boolean "isDelete", default: false
    t.integer "created_by"
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.string "user_role_type"
  end

  create_table "selected_mentors", force: :cascade do |t|
    t.integer "user_id"
    t.integer "startup_profile_id"
    t.string "title"
    t.boolean "isActive", default: true
    t.integer "created_by"
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.boolean "isDelete", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["startup_profile_id"], name: "index_selected_mentors_on_startup_profile_id"
    t.index ["user_id"], name: "index_selected_mentors_on_user_id"
  end

  create_table "session_attendees", force: :cascade do |t|
    t.integer "session_id"
    t.integer "user_id"
    t.string "role"
    t.boolean "attendence_confirmation", default: true
    t.integer "startup_profile_id"
    t.boolean "isActive", default: true
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_session_attendees_on_session_id"
    t.index ["startup_profile_id"], name: "index_session_attendees_on_startup_profile_id"
    t.index ["user_id"], name: "index_session_attendees_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.text "where"
    t.integer "program_id"
    t.boolean "isActive", default: true
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_sessions_on_program_id"
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
    t.integer "startup_registration_id"
    t.boolean "logged_in_first_time", default: true
    t.index ["startup_registration_id"], name: "index_startup_profiles_on_startup_registration_id"
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
    t.integer "program_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "created_by"
    t.boolean "isDelete", default: false
    t.boolean "isActive", default: true
    t.datetime "deleted_at"
    t.string "deleted_by"
    t.string "founder_name"
    t.string "founder_email"
    t.string "founder_phone_number"
    t.text "founder_skills"
    t.text "founder_credentials"
    t.text "founder_experience"
    t.text "founder_commitment"
    t.string "startup_address_line_1"
    t.string "startup_address_line_2"
    t.string "startup_city"
    t.string "startup_state_province_region"
    t.string "startup_zip_pincode_postalcode"
    t.string "startup_country"
    t.string "startup_geo_location"
    t.string "application_status"
    t.string "app_status_description"
    t.boolean "contract_signed"
    t.datetime "contract_signed_date"
    t.datetime "contract_received_date"
    t.boolean "current_state_form", default: false
    t.boolean "current_state_form_reviewed", default: false
    t.integer "score", default: 0
    t.index ["program_id"], name: "index_startup_registrations_on_program_id"
    t.index ["program_status_id"], name: "index_startup_registrations_on_program_status_id"
  end

  create_table "startup_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "startup_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["startup_profile_id"], name: "index_startup_users_on_startup_profile_id"
    t.index ["user_id"], name: "index_startup_users_on_user_id"
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
    t.boolean "show_rule", default: false
    t.string "user_role_type"
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
    t.string "user_type"
    t.string "designation"
    t.boolean "is_first_time_logged_in", default: true
  end

end
