class CreateContractForms < ActiveRecord::Migration[5.2]
  def change
    create_table :contract_forms do |t|
      t.integer :contract_manager_id
      t.references :startup_registration, foreign_key: true
      t.references :program, foreign_key: true
      t.references :additional_contract_information, foreign_key: true
      t.datetime :from_date
      t.datetime :to_date
      t.string :duration
      t.string :p_1_name
      t.text :p_1_address
      t.string :p_1_phone_number
      t.string :p_1_email
      t.string :p_2_name
      t.text :p_2_address
      t.string :p_2_phone_number
      t.string :p_2_email
      t.integer :contract_id
      t.boolean :accept_terms_condition
      t.boolean :contract_signed
      t.datetime :signed_date
      t.boolean :isActive
      t.boolean :isDelete
      t.integer :deleted_by
      t.datetime :deleted_date
      t.datetime :contract_send_date

      t.timestamps
    end
  end
end
