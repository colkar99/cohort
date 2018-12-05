class AddStageToProgramStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :program_statuses, :stage, :string
  end
end
