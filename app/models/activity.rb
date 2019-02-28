class Activity < ApplicationRecord
  has_many :course_activity_links
  has_many :courses, through: :course_activity_links ,:dependent => :delete_all 
  # belongs_to :checklist
  # has_many :checklists 
  has_many :activity_responses
     attr_accessor :startup_response,:startup_responsed,:admin_responsed,:mentor_responsed



  #   def self.list_with_scope(user=nil, params={})
  #   arel = super(user, params)
  #   arel = arel.joins(:offer, :buyer).where(user_id: user.id)
  #   arel = arel.select("users.name as user_name, liked_offers.*, offers.name as offer_name")
  #   arel
  # end
end
