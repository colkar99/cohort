class FrameworkSerializer < ActiveModel::Serializer
  attributes :id ,:title,:description,:level,:main_image,:thumb_image,:created_at,:updated_at
  has_many :courses
  
end

