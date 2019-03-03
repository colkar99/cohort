class AddInvitedToSession < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :invited, :boolean,default: false
  end
end
