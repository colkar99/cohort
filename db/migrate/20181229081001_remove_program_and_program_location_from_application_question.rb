class RemoveProgramAndProgramLocationFromApplicationQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_reference :application_questions, :program, foreign_key: true
    remove_reference :application_questions, :program_location, foreign_key: true
  end
end
