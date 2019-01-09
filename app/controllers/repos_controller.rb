class ReposController < ApplicationController
  def index
    

    authorize! :index, Repos
  end
end
