class AddAdminIdAndMentorIdToActivityResponse < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_responses, :admin_id, :integer
    add_column :activity_responses, :mentor_id, :integer
  end
end
