# lib/json_web_token.rb

class JsonWebToken
 class << self
   def encode(payload, exp = 360.days.from_now)
     payload[:exp] = exp.to_i
     byebug
     JWT.encode(payload, secret_key)
   end

   def decode(token)
     body = JWT.decode(token, secret_key)[0]
     HashWithIndifferentAccess.new body
   rescue
     nil
   end
 end

 private

 def self.secret_key
   ENV["APP_SECRET_KEY"]
 end
end