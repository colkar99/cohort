class ProgramSerializer < ActiveModel::Serializer
  attributes :id ,:title,:description,:start_date,:end_date,:seat_size,:industry,:main_image,:logo_image,:duration,:application_start_date,
  				:application_end_date,:created_by,:isDelete,:deleted_by,:deleted_date,:created_at,:updated_at,:ProgramLocation_id,:isActive,
  				:framework_id,:site_admin,:program_admin,:program_director,:application_manager,:contract_manager
  # def checklists
  # 	object.checklists
  # end
  belongs_to :program_type
  belongs_to :ProgramLocation
  has_many :application_questions , through: :link_of_program_questions
end


    # t.integer "program_type_id"
    # t.string "title"
    # t.text "description"
    # t.string "start_date"
    # t.string "end_date"
    # t.integer "program_admin_id"
    # t.integer "seat_size"
    # t.string "industry"
    # t.string "main_image"
    # t.string "logo_image"
    # t.string "duration"
    # t.string "application_start_date"
    # t.string "application_end_date"
    # t.integer "created_by"
    # t.boolean "isDelete", default: false
    # t.integer "deleted_by"
    # t.string "deleted_date"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.integer "ProgramLocation_id"
    # t.boolean "isActive", default: true
    # t.integer "framework_id"
    # t.integer "site_admin"
    # t.integer "program_admin"
    # t.integer "program_director"
    # t.integer "application_manager"
    # t.integer "contract_manager"
    # t.index ["ProgramLocation_id"], name: "index_programs_on_ProgramLocation_id"
    # t.index ["framework_id"], name: "index_programs_on_framework_id"
    # t.index ["program_type_id"], name: "index_programs_on_program_type_id"