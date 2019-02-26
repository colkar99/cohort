class AddAdminResponsedAndMentorResponsedToActivityResponse < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_responses, :admin_responsed, :boolean,default: false
    add_column :activity_responses, :mentor_responsed, :boolean,default: false
  end
end
