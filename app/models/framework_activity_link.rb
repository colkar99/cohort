class FrameworkActivityLink < ApplicationRecord
  belongs_to :framework
  belongs_to :activity
end
