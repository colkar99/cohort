class RemoveFrameworkFromChecklist < ActiveRecord::Migration[5.2]
  def change
    remove_reference :checklists, :framework, foreign_key: true
  end
end
