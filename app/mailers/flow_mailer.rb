class FlowMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.login.subject
  #
  def csfi(startup_reg)
    @startup = startup_reg 

    mail to: @startup.founder_email, subject: "Current state form initialized"
  end

  def accepted(startup_reg)
    @startup = startup_reg 

    mail to: @startup.founder_email, subject: "Congrats!!!"
  end

  def startup_profile_created(profile,user,password)
    @profile = profile
    @password = password
    @user = user

      mail to: @user.email, subject: "Profile created"
  end

end
