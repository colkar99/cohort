class AddPassMetricToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :pass_metric, :text
  end
end
