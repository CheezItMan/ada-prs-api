class ClassesController < ApplicationController
  load_and_authorize_resource class: 'Classroom', param_method: :classroom_params
  before_action :authenticate_user!

  before_action :select_classroom, only: [:update, :create, :show, :destroy]

  def index
    render json: {
      ok: true,
      classes: Classroom.order(:cohort_number, :name)
    }, status: :ok

    authorize! :index, Classroom
  end

  def show 
    if @classroom
      render_classroom(@classroom)
    else
      render_error(['Not Found'])
    end
    
    authorize! :show, @classroom
  end

  def update
    authorize! :update, @classroom

    if @classroom.update(classroom_params)
      render_classroom(@classroom)
    else
      render_error(classroom.errors.messages, :bad_request)
    end
  end

  def create
    classroom = Classroom.create(classroom_params)
    if classroom.valid?
      render_classroom(classroom)
    else
      render_error(classroom.errors.messages, :bad_request)
    end

    authorize! :create, classroom
  end

  def destroy 
    if @classroom
      @classroom.destroy
      render_classroom(@classroom)
    else
      render_error(['Not Found'])
    end

    authorize! :destroy, @classroom
  end

  

  private 

  def select_classroom
    @classroom = Classroom.find_by(id: params[:id])
  end

  def classroom_params
    return params.require(:classroom).permit(:cohort_number, :name)
  end

  def render_classroom(classroom, status = :ok)
    render json: {
      ok: status === :ok,
      classroom: classroom
    }, status: status
  end

  def render_error(messages, status = :not_found)
    render json: {
      ok: false,
      messages: messages
    }, status: status

  end
end
