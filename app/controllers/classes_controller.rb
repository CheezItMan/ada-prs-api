class ClassesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      ok: true,
      classes: Classroom.all
    }, status: :ok

  end
end
