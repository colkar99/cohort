# app/commands/authenticate_user.rb

class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password,type)
    @email = email
    @password = password
    @type = type
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    if @type == 'google'
      return user if user 
      errors.add :message, 'User with this email id not registered with us!'
      nil
    else
      return user if user && user.authenticate(password)

      errors.add :message, 'invalid credentials'
      nil
    end
  end
end