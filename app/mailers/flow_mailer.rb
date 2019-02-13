class FlowMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.login.subject
  #
  def startup_application_registered(startup_app)
    @startup = startup_app
      mail to: @startup.founder_email, subject: "Thank you for your interest"
  end

  def startup_registration_admin_notification(program_admin,program_dir,application_manager,startup,program)
    @program_dir = program_dir
    @program_admin = program_admin
    @application_manager = application_manager
    @startup = startup
    @program = program
  
      mail(:to => @program_dir.email ,  :subject => "New Startup Registered",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@application_manager.email] )
  end

  def csfi(startup_reg)
    @startup = startup_reg 

    mail to: @startup.founder_email, subject: "Current state form initialized"
  end

  def startup_response_for_current_state_form(program_admin,program_dir,application_manager,startups,program)
    @program_admin = program_admin
    @program_dir = program_dir
    @application_manager = application_manager
    @startup = startups
    @program = program

    mail(:to => [@program_dir.email,@program_admin.email] ,  :subject => "Current state forms submitted",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@application_manager.email] )
  end

  def accepted(startup_reg)
    @startup = startup_reg 

    mail to: @startup.founder_email, subject: "Congrats!!!"
  end

  def contract_form_created(startup_reg)
    @startup = startup_reg 

    mail to: @startup.founder_email, subject: "Contract Request"
  end

  def startup_profile_created(profile,user,password)
    @profile = profile
    @password = password
    @user = user

      mail to: @user.email, subject: "Profile created"
  end

  def notification_contract_manager(program_admin,program_dir,application_manager,contract_manager,startups,program)
    @program_admin = program_admin
    @program_dir = program_dir
    @application_manager = application_manager
    @contract_manager = contract_manager
    @startups = startups
    @program = program

      mail(:to => @contract_manager.email ,  :subject => "Startup application accepted",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_dir.email,@application_manager.email,@program_admin.email] )
  end

  def admin_notification_for_current_state_form(program_admin,program_dir,application_manager,startups,program)
    @program_admin = program_admin
    @program_dir = program_dir
    @application_manager = application_manager
    @startups = startups
    @program = program

          mail(:to => @program_dir.email ,  :subject => "Current state forms initialized",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@application_manager.email] )
  end
end
