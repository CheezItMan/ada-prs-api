# lib/json_web_token.rb

module JsonWebToken
  def self.encode(sub)
    payload = {
      iss: ENV['CLASSROOM_CLIENT_URL'],
      sub: sub,
      exp: 4.hours.from_now.to_i,
      iat: Time.now.to_i
    }
    return JWT.encode payload, ENV['JWT_SECRET'], 'HS256'
  end

  def self.decode(token)
    # decodes the token to get user data
    options = {
      iss: ENV['CLASSROOM_CLIENT_URL'],
      verify_iss: true,
      verify_iat: true,
      leeway: 30,  # Add 30 seconds of leeway for clock skew
      algorithm: 'HS256'
    }
    return JWT.decode token, ENV['JWT_SECRET'], true, options
  end
end
