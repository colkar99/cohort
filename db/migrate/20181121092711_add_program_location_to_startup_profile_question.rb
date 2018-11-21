class AddProgramLocationToStartupProfileQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :startup_profile_questions, :program_location, foreign_key: true
  end
end
