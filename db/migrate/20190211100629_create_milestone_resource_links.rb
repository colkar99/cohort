class CreateMilestoneResourceLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :milestone_resource_links do |t|
      t.references :milestone, foreign_key: true
      t.references :resource, foreign_key: true
      t.references :road_map, foreign_key: true

      t.timestamps
    end
  end
end
