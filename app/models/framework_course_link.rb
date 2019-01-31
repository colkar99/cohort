class FrameworkCourseLink < ApplicationRecord
  belongs_to :framework
  belongs_to :course
end
