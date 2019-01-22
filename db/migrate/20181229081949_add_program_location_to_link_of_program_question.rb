class AddProgramLocationToLinkOfProgramQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :link_of_program_questions, :program_location, foreign_key: true
  end
end
