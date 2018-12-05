class AddStartupResponseAndAdminResponseToAppQuesResponse < ActiveRecord::Migration[5.2]
  def change
    add_column :app_ques_responses, :startup_response, :boolean ,default: false
    add_column :app_ques_responses, :admin_response, :boolean, default: false
  end
end
