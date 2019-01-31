class ChangeFrameworkActivityLinkToCourseActivityLink < ActiveRecord::Migration[5.2]
  def change
  	rename_table :framework_activity_links, :course_activity_links
  end
end
