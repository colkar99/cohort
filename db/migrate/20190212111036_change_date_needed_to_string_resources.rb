class ChangeDateNeededToStringResources < ActiveRecord::Migration[5.2]
  def change
  	change_column :resources, :date_needed, :string
  end
end
