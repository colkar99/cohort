class RemoveProgramLocationsFromLinkOfProgramQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_reference :link_of_program_questions, :program_locations, foreign_key: true
  end
end
