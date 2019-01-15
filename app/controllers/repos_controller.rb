# frozen_string_literal: true

class ReposController < ApplicationController
  before_action :find_classroom, only: [:index, :show]

  def index
    authorize! :index, Repo

    ap "CLASSROOM APP"
    ap @classroom
    puts params

    if @classroom
      @repos = @classroom.repos
    else
      @repos = Repo.all
    end

    if @repos
      render json: {
        ok: true,
        repos: @repos,
      }, status: :ok
    else
      render json: {
        ok: false,
        message: "Not found",
      }, status: :not_found
    end
  end

  def show
    repo = Repo.find_by id: params[:id]
    students = @classroom.students
  end

  private

  def find_classroom
    @classroom = Classroom.find_by(id: params[:class_id])
  end
end
