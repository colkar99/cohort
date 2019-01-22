class CreateLinkOfProgramQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :link_of_program_questions do |t|
      t.references :application_question, foreign_key: true
      t.references :program, foreign_key: true
      t.references :program_locations, foreign_key: true

      t.timestamps
    end
  end
end
