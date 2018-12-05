module V1
	 class MailersController < ApplicationController
	 	# skip_before_action :authenticate_request, only: [:create,:show,:edit]
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
		def self.program_startup_status(startup)
			program = Program.find(startup.program_id)
			if startup.application_status == "PR"
				 ###########send mail to program admin##########
			elsif startup.application_status == "AA" 
				###########send mail to contract manager##########
				###########send mail to startup that they are accept,Please go fill contract form##########
			elsif startup.application_status ==  "AR"
				###########send mail to startup that they are rejected##########			
			elsif startup.application_status == "CFR"
				###########send mail to startup to fillup contract form##########			
			elsif startup.application_status == "CSWFP"
				binding.pry			
				###########send mail to contract_manager to verify contract##########			
				###########send mail to program_director they signed contract success##########			
			end  
			
		end

	 end
end

# ProgramStatus.create!(status:"PR",description: "program registered")
# ProgramStatus.create!(status:"AA",description: "Application accepted")
# ProgramStatus.create!(status:"AR",description: "Application Rrejected")
# ProgramStatus.create!(status:"CFR",description: "Contract form received")
# ProgramStatus.create!(status:"CS",description: "Contract form Signed by startup")