class AddStartupRegistrationToCurrentStateForm < ActiveRecord::Migration[5.2]
  def change
    add_reference :current_state_forms, :startup_registration, foreign_key: true
  end
end
