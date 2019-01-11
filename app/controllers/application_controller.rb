class ApplicationController < ActionController::API
  def current_user
    token = request.headers['authorization']

    if token.nil?
      return nil
    end

    payload = JsonWebToken.decode(token)
    return @current_user ||= User.find_by_login(payload[0]['sub'])
  end

  def logged_in?
    return current_user != nil
  end

  def authenticate_user!
    head :unauthorized unless logged_in?
  end

  def not_found
    render json: {
      ok: false,
      message: 'That resource cannot be found'
    }, status: :not_found
  end

  rescue_from JWT::ExpiredSignature do |exception|
    render json: {
      ok: false,
      message: exception.message
    }, status: :unauthorized
  end

  rescue_from JWT::DecodeError do |exception|
    render json: {
      ok: false,
      message: exception.message
    }, status: :unauthorized
  end
 

  rescue_from CanCan::AccessDenied do |exception|
    render json: {
      ok: false,
      message: exception.message
    }, status: :unauthorized
  end
end
