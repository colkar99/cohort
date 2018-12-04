class ContractForm < ApplicationRecord
  belongs_to :startup_registration
  belongs_to :program
  belongs_to :additional_contract_information

  after_commit :set_contract_id, on: :create

  def set_contract_id
  	self.contract_id = Time.now.strftime('%s') + "" +self.id
  	self.save!
  end

end
