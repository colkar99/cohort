class CreateProgramTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :program_types do |t|
      t.string :program_type_title
      t.text :program_type_description
      t.string :program_type_duration
      t.string :program_type_logo
      t.string :program_type_main_image

      t.timestamps
    end
  end
end
