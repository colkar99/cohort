class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.login.subject
  #
  def login(user)
    @user = user

    mail to: @user.email, subject: "Logged in"
  end

  def registration(user)
  	@user = user
  	mail to: @user.email , subject: "Registered"
  end

  def password_reset(user)
      @user = user
      mail to: @user.email , subject: "Password reset"
  end
  def first_time_logged_in(user)
      @user = user
      mail to: @user.email , subject: "Congrats!!"
  end
  def send_quiries_to_admin(program_admin,program_director,contract_manager)
    
    mail to: @user.email , subject: "Congrats!!"
  end
end
