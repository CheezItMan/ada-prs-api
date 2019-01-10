class AuthenticationController < ApplicationController
  def github    
    authenticator = Authenticator.new
    user_info = authenticator.github(params[:code])

    login = user_info[:login]
    name = user_info[:name]
    avatar_url = user_info[:avatar_url]
    email = user_info[:email]
    uid = user_info[:id]
    access_token = user_info[:access_token]

    # Generate token
    token = JsonWebToken.encode(login)
    # create a user if it doesn't exist
    user = User.where(uid: uid).first_or_create!(
      name: name,
      login: login,
      avatar_url: avatar_url,
      email: email,
      uid: uid
    )
 
    # Save the current access token in the model to use act on their behalf in github
    user.current_access_token = access_token
    user.save

    # and redirect to the client app
    redirect_to "#{issuer}/auth?token=#{token}"
  rescue StandardError => error
    redirect_to "#{issuer}?error=#{error.message}"
  end

  private
    
    def issuer
      return ENV['CLASSROOM_CLIENT_URL']
    end
end
