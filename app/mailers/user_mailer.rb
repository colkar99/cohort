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
end
