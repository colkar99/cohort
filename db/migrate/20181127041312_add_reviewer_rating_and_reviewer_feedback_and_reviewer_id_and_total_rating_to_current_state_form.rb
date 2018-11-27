class AddReviewerRatingAndReviewerFeedbackAndReviewerIdAndTotalRatingToCurrentStateForm < ActiveRecord::Migration[5.2]
  def change
    add_column :current_state_forms, :reviewer_rating, :integer
    add_column :current_state_forms, :reviewer_feedback, :string
    add_column :current_state_forms, :reviewer_id, :integer
    add_column :current_state_forms, :total_rating, :integer
  end
end
