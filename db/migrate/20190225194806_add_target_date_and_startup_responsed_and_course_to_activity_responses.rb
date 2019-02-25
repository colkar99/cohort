class AddTargetDateAndStartupResponsedAndCourseToActivityResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_responses, :target_date, :string
    add_column :activity_responses, :startup_responsed, :boolean,default: false
    add_reference :activity_responses, :course, foreign_key: true
  end
end
