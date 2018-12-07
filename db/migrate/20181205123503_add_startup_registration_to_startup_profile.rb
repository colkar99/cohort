class AddStartupRegistrationToStartupProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :startup_profiles, :startup_registration, foreign_key: true
  end
end
