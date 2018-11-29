class CreateStartupQuestionResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :startup_question_responses do |t|
      t.references :startup_question, foreign_key: true
      t.references :startup_profile, foreign_key: true
      t.text :response
      t.references :program, foreign_key: true
      t.integer :reviewer_rating
      t.text :reviewer_feedback
      t.references :program_location, foreign_key: true

      t.timestamps
    end
  end
end
