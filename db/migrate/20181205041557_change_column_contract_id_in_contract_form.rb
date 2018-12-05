class ChangeColumnContractIdInContractForm < ActiveRecord::Migration[5.2]
  def change
  	  change_column :contract_forms, :contract_id, :string

  end
end
