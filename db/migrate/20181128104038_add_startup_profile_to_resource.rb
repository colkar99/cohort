class AddStartupProfileToResource < ActiveRecord::Migration[5.2]
  def change
    add_reference :resources, :startup_profile, foreign_key: true
  end
end
