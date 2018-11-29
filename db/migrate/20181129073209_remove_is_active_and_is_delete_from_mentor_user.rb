class RemoveIsActiveAndIsDeleteFromMentorUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :mentor_users, :isActive, :boolean
    remove_column :mentor_users, :isDelete, :boolean
  end
end
