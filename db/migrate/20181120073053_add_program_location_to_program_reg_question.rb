class AddProgramLocationToProgramRegQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :program_reg_questions, :program_location, foreign_key: true
  end
end
