class AddStartupRegistrationToAppQuesResponse < ActiveRecord::Migration[5.2]
  def change
    add_reference :app_ques_responses, :startup_registration, foreign_key: true
  end
end
