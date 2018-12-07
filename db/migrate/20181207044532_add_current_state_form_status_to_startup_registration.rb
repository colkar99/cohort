class AddCurrentStateFormStatusToStartupRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_registrations, :current_state_form, :boolean, default: false
  end
end
