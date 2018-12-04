class AddContractSignedAndContractSignedDateAndContractReceivedDateToStartupRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_registrations, :contract_signed, :boolean
    add_column :startup_registrations, :contract_signed_date, :datetime
    add_column :startup_registrations, :contract_received_date, :datetime
  end
end
