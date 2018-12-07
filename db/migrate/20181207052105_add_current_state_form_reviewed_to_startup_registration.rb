class AddCurrentStateFormReviewedToStartupRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_registrations, :current_state_form_reviewed, :boolean,default: false
  end
end
