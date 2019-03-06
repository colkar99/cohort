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
    @startup_profile = startup_profile
    @program = program
    @program_admin = program_admin
    @program_director = program_director
    @startup_user = startup_user
    mail(:to => [@startup_user.email] ,  :subject => "Venture development courses responsed (checklists)",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@program_director.email] )
  end
  def course_completed_by_startup(course,startup_profile,program,program_admin,program_director,startup_user)
    @course = course
    @startup_profile = startup_profile
    @program = program
    @program_admin = program_admin
    @program_director = program_director
    @startup_user = startup_user
    mail(:to => [@startup_user.email] ,  :subject => "Venture development course completed (checklists)",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@program_director.email] )
  end

end
