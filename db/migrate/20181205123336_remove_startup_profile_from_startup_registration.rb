class RemoveStartupProfileFromStartupRegistration < ActiveRecord::Migration[5.2]
  def change
    remove_reference :startup_registrations, :startup_profile, foreign_key: true
  end
end
