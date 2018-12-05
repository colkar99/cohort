class RemoveStartupApplicationIdFromAppQuesResponse < ActiveRecord::Migration[5.2]
  def change
    remove_column :app_ques_responses, :startup_application_id, :integer
  end
end
