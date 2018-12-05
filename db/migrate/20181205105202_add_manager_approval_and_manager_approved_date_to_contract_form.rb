class AddManagerApprovalAndManagerApprovedDateToContractForm < ActiveRecord::Migration[5.2]
  def change
    add_column :contract_forms, :manager_approval, :boolean,default: false
    add_column :contract_forms, :manager_approved_date, :datetime
  end
end
