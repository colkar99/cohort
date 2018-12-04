class AddReviewedByToAppQuesResponse < ActiveRecord::Migration[5.2]
  def change
    add_column :app_ques_responses, :reviewed_by, :integer
  end
end
