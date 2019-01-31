class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.text :title
      t.text :description
      t.text :additional_description
      t.boolean :isActive ,default: :true
      t.integer :deleted_by
      t.string :deleted_at
      t.integer :created_by

      t.timestamps
    end
  end
end
