class CreateMilestones < ActiveRecord::Migration[5.2]
  def change
    create_table :milestones do |t|
      t.string :name
      t.text :description
      t.text :metric
      t.references :road_map, foreign_key: true

      t.timestamps
    end
  end
end
