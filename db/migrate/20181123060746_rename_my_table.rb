class RenameMyTable < ActiveRecord::Migration[5.2]
   def self.up
    rename_table :avtivity_responses, :activity_responses
  end

  def self.down
    rename_table :activity_responses, :avtivity_responses
  end
end
