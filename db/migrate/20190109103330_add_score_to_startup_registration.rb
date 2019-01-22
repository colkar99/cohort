class AddScoreToStartupRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_registrations, :score, :integer,default: 0
  end
end
