class CreateAdditionalContractInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :additional_contract_informations do |t|
      t.text :purpose_of_contract
      t.text :contract_termination
      t.text :contract_terms_condition
      t.text :authorization

      t.timestamps
    end
  end
end
