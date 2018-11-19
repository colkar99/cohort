class CreateProgramRegQuesResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :program_reg_ques_responses do |t|
      t.references :program_reg_question, foreign_key: true
      t.references :startup_profile, foreign_key: true
      t.text :response
      t.integer :response_id
      t.integer :reviewer_rating
      t.text :reviewer_feedback
      t.references :program_location, foreign_key: true

      t.timestamps
    end
  end
end
