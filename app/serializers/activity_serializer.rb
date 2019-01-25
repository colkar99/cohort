class ActivitySerializer < ActiveModel::Serializer
  attributes :id ,:name,:description,:placeholder,:order,:framework_id,:created_at,:updated_at,:checklists
  def checklists
  	object.checklists
  end
end

