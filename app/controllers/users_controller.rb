class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:show]

  def index
    render json: {
      ok: true,
      users: User.all,
    }, status: :ok
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      if @current_user.admin? || user.id == @current_user.id
        render_user(user)
      else
        render json: {
          ok: false,
          message: 'You are unauthorized to view this resource'
        }, status: :unauthorized
      end
    else
      render_not_found
    end

    authorize! :show, user


  end

  private 

  def render_user(user) 
    render json: {
      ok: true,
      user: user.as_json()
    }, status: :ok
  end
end
