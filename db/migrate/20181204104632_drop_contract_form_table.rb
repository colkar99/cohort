class DropContractFormTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :contract_forms
  end
end
