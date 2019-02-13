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
  def send_queries_to_admin(program_admin,program_director,contract_manager,params,startup_app)
    @program_admin = program_admin
    @program_director = program_director
    @contract_manager = contract_manager
    @values = params
    @startup_app = startup_app
    mail(:to => @contract_manager.email ,  :subject => "Queries",
     # :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"] ,
     :cc => [@program_admin.email,@program_director.email] )
  end
  def resource_request_to_admin(startup_profile,program,program_director,resource)
    @startup_profile = startup_profile
    @program = program
    @program_director = program_director
    @resource = resource
    
    mail to: @program_director.email , subject: "Resource Request!!"
  end
  def user_create_by_admin(user,current_user)
      @user = user
      @current_user = current_user
    
    mail to: @user.email , subject: "Create password!!"
  end
end
