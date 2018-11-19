class CreateProgramStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :program_statuses do |t|
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
