# lib/json_web_token.rb

class JsonWebToken
 class << self
  #(payload, exp = 90.days.from_now)
   def encode(payload)
     # payload[:exp] = exp.to_i
     # byebug
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
   # ENV["APP_SECRET_KEY"]
   "150ae0047fa32b35e74ba52cda37a61df05f0e56b29040ce96978be9e4fce2f4dc05738f17dcfd90469e8ca1bb74fe00f2f04693f020c7a068b9c7a771e38528"
 end
end