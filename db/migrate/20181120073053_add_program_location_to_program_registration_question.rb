class AddProgramLocationToProgramRegistrationQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :program_registration_questions, :program_location, foreign_key: true
  end
end
