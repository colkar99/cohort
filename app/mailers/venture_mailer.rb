class VentureMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.login.subject
  #
  def assign_activities_mail(startup_application,courses,program)
    @program = program
    @program_admin = User.find(program.program_admin)
    @application_manager = User.find(program.application_manager)
    @program_dir =  User.find(program.program_director)
    @startup_application = startup_application
    @courses = courses

     mail(:to => @startup_application.founder_email ,  :subject => "Venture development courses assigned",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@application_manager.email,@program_dir.email] )
  end
    def send_courses_reminder(course,startup_user,program_dir,program_admin,program,startup_profile,target_date)
    @program = program
    @program_admin =program_admin
    @program_dir = program_dir
    @startup_profile = startup_profile
    @course = course
    @startup_user = startup_user
    @target_date = target_date

     mail(:to => @startup_user.email ,  :subject => "Venture development courses reminder",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@program_dir.email] )
  end

  def activities_responsed_by_startups(course,activity,startup_profile,program,program_admin,program_director,application_manager)
    @course = course
    @activity = activity
    @startup_profile = startup_profile
    @program = program
    @program_admin = program_admin
    @program_director = program_director
    @application_manager = application_manager
    
    mail(:to => [@program_admin.email,@program_director.email] ,  :subject => "Venture development courses responsed (startup)",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@application_manager.email] )
  end

  def activities_responsed_by_admin(course,activity,startup_profile,program,program_admin,program_director,startup_user)
    @course = course
    @activity = activity
    @startup_profile = startup_profile
    @program = program
    @program_admin = program_admin
    @program_director = program_director
    @startup_user = startup_user
    mail(:to => [@startup_user.email] ,  :subject => "Venture development courses responsed (admin)",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@program_director.email] )
  end

    def checklists_responsed_by_admin(course,startup_profile,program,program_admin,program_director,startup_user)
    @course = course
    @checklists = checklists
    @startup_profile = startup_profile
    @program = program
    @program_admin = program_admin
    @program_director = program_director
    @startup_user = startup_user
    mail(:to => [@startup_user.email] ,  :subject => "Venture development courses responsed (checklists)",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@program_director.email] )
  end
  # def startup_application_registered(startup_app)
  #   @startup = startup_app
  #     mail to: @startup.founder_email, subject: "Thank you for your interest"
  # end

  # def startup_registration_admin_notification(program_admin,program_dir,application_manager,startup,program)
  #   @program_dir = program_dir
  #   @program_admin = program_admin
  #   @application_manager = application_manager
  #   @startup = startup
  #   @program = program
  
  #     mail(:to => @program_dir.email ,  :subject => "New Startup Registered",
  #    # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
  #    :cc => [@program_admin.email,@application_manager.email] )
  # end

  # def csfi(startup_reg)
  #   @startup = startup_reg 

  #   mail to: @startup.founder_email, subject: "Current state form initialized"
  # end

  # def startup_response_for_current_state_form(program_admin,program_dir,application_manager,startups,program)
  #   @program_admin = program_admin
  #   @program_dir = program_dir
  #   @application_manager = application_manager
  #   @startup = startups
  #   @program = program

  #   mail(:to => [@program_dir.email,@program_admin.email] ,  :subject => "Current state forms submitted",
  #    # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
  #    :cc => [@application_manager.email] )
  # end
  # def startup_response_for_contract(program_admin,program_dir,application_manager,contract_manager,startup_application,program)
  #   @program_admin = program_admin
  #   @program_dir = program_dir
  #   @application_manager = application_manager
  #   @contract_manager = contract_manager
  #   @startup = startup_application
  #   @program = program

  #   mail(:to => @contract_manager.email ,  :subject => "Contract forms signed",
  #    # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
  #    :cc => [@application_manager.email,@program_dir.email,@program_admin.email] )
  # end

  # def accepted(startup_reg)
  #   @startup = startup_reg 

  #   mail to: @startup.founder_email, subject: "Congrats!!!"
  # end

  # def contract_form_created(startup_reg)
  #   @startup = startup_reg 

  #   mail to: @startup.founder_email, subject: "Contract Request"
  # end

  # def startup_profile_created(profile,user,password)
  #   @profile = profile
  #   @password = password
  #   @user = user

  #     mail to: @user.email, subject: "Profile created"
  # end

  # def notification_contract_manager(program_admin,program_dir,application_manager,contract_manager,startups,program)
  #   @program_admin = program_admin
  #   @program_dir = program_dir
  #   @application_manager = application_manager
  #   @contract_manager = contract_manager
  #   @startups = startups
  #   @program = program

  #     mail(:to => @contract_manager.email ,  :subject => "Startup application accepted",
  #    # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
  #    :cc => [@program_dir.email,@application_manager.email,@program_admin.email] )
  # end

  # def admin_notification_for_current_state_form(program_admin,program_dir,application_manager,startups,program)
  #   @program_admin = program_admin
  #   @program_dir = program_dir
  #   @application_manager = application_manager
  #   @startups = startups
  #   @program = program

  #         mail(:to => @program_dir.email ,  :subject => "Current state forms initialized",
  #    # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
  #    :cc => [@program_admin.email,@application_manager.email] )
  # end
end
