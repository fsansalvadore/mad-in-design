class ProjectsController < ApplicationController
  def index
    @projects = Project.where(published: true).order(start_date: :desc)
  end

  def show
  end
end
