class StartupRegistration < ApplicationRecord
  belongs_to :program 
  has_one :startup_profile
  belongs_to :program_status
  has_many :app_ques_responses
  has_one :current_state_form

  # after_commit :reg_mail_to_admin, on: :create

  # def reg_mail_to_admin
  # 	binding.pry
  # 	program = self.program
  #   ###########send mail notification to user##############
  #   #director = User.find(program[:program_director])
  # 	######################################################
  # 	binding.pry
  # end

end
