class CourseActivityLink < ApplicationRecord
  belongs_to :course
  belongs_to :activity
end
