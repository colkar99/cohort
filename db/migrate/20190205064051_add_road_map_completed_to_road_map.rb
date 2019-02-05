class AddRoadMapCompletedToRoadMap < ActiveRecord::Migration[5.2]
  def change
  	add_column :road_maps, :road_map_completed, :boolean, default: :false
  end
end
