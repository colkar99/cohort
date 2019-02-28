class AddCourseToChecklist < ActiveRecord::Migration[5.2]
  def change
    add_reference :checklists, :course, foreign_key: true
  end
end
