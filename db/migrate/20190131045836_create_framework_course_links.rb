class CreateFrameworkCourseLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :framework_course_links do |t|
      t.references :framework, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
