class SessionSerializer < ActiveModel::Serializer
    attributes :id ,:title,:description,:start_date_time,:end_date_time,:where,:invited,:created_at,:updated_at
	has_many :session_attendees
	has_many :users, through: :session_attendees
end

    # t.text "title"
    # t.text "description"
    # t.datetime "start_date_time"
    # t.datetime "end_date_time"
    # t.text "where"
    # t.integer "program_id"
    # t.boolean "isActive", default: true
    # t.integer "created_by"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.boolean "invited", default: false