class HomepageController < ApplicationController
  def index
    render json: {
      ok: true,
      message: "Welcome to the Ada classroom API, to log in, use a designated front-end"
    }, status: :ok
  end
end
