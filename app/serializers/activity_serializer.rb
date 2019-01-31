class ActivitySerializer < ActiveModel::Serializer
  attributes :id ,:name,:description,:placeholder,:order,:created_at,:updated_at,:checklists
  def checklists
  	object.checklists
  end
end

