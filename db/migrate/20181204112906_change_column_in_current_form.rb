class ChangeColumnInCurrentForm < ActiveRecord::Migration[5.2]
  def change
  	change_column :contract_forms, :isActive, :boolean, default: true
  	change_column :contract_forms, :isDelete, :boolean, default: false
  	change_column :contract_forms, :accept_terms_condition, :boolean, default: false
  	change_column :contract_forms, :contract_signed, :boolean, default: false

  end
end
