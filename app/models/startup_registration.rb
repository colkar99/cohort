class StartupRegistration < ApplicationRecord
  belongs_to :program 
  # belongs_to :startup_profile
  belongs_to :program_status

  after_commit :reg_mail_to_admin, on: :create

  def reg_mail_to_admin
  	binding.pry
  	program = self.program
    ###########send mail notification to user##############
    director = User.find(program[:program_director])
  	######################################################
  	binding.pry
  end

end
