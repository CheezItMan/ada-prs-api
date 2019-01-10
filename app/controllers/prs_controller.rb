class PrsController < ApplicationController
  def index
    classroom = Classroom.find_by(id: params[:id])

    render json: {
      ok: true,
      repos: classroom.repos
    }, status: :ok
  end
end
