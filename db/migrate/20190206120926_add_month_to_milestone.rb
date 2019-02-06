class AddMonthToMilestone < ActiveRecord::Migration[5.2]
  def change
    add_column :milestones, :month, :string
  end
end
