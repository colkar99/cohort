class CreateFrameworkActivityLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :framework_activity_links do |t|
      t.references :framework, foreign_key: true
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
