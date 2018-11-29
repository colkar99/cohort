class AddIsActiveAndIsDeleteToMentorUser < ActiveRecord::Migration[5.2]
  def change
    add_column :mentor_users, :isActive, :boolean ,default: true
    add_column :mentor_users, :isDelete, :boolean ,default: false
  end
end
