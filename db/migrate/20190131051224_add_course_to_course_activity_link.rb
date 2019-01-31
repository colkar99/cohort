class AddCourseToCourseActivityLink < ActiveRecord::Migration[5.2]
  def change
    add_reference :course_activity_links, :course, foreign_key: true
  end
end
