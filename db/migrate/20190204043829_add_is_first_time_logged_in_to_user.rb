class AddIsFirstTimeLoggedInToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_first_time_logged_in, :boolean,default: :true
  end
end
