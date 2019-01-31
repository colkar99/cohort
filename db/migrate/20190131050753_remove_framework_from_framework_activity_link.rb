class RemoveFrameworkFromFrameworkActivityLink < ActiveRecord::Migration[5.2]
  def change
    remove_reference :framework_activity_links, :framework, foreign_key: true
  end
end
