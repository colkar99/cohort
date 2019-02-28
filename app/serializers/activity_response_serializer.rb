class ActivityResponseSerializer < ActiveModel::Serializer
    attributes :id ,:startup_response,:startup_profile_id,:activity_id,:admin_rating,:admin_feedback,:mentor_rating,:mentor_feedback,:target_date,:startup_responsed,:admin_responsed,:mentor_responsed
end

