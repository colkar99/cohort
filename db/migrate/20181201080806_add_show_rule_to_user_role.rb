class AddShowRuleToUserRole < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :show_rule, :boolean, default: false
  end
end
