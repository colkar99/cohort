class AddLoggedInFirstTimeToStartupProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_profiles, :logged_in_first_time, :boolean, default: :false
  end
end
