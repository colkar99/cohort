class CreateMentorUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :mentor_users do |t|
      t.references :user, foreign_key: true
      t.string :type
      t.text :title
      t.text :company
      t.string :linked_in_url
      t.string :facebook_url
      t.text :primary_expertise
      t.text :why_mentor
      t.text :startup_experience
      t.text :startup_experience_level
      t.text :expertise_expanded
      t.datetime :start_date
      t.datetime :end_date
      t.text :commitment
      t.string :mentorship_type
      t.text :looking_for
      t.string :visibility
      t.text :area_of_expertise
      t.boolean :isActive
      t.boolean :isDelete
      t.integer :created_by
      t.integer :deleted_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
