class SocialMediaLink < ApplicationRecord
  belongs_to :social_media
  belongs_to :startup_profile
end
