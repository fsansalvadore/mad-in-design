class ProjectsController < ApplicationController
  def index
    @projects = Project.where(published: true).order(start_date: :desc)
    @years = []
    @projects.filter {|project| @years << project.start_date.year}
    @years.uniq!
  end

  def show
    @project = Project.friendly.find_by_slug(params[:slug])
    @sections = @project.project_content_sections.all.order(position: :asc)
    @suggestions = Project.where("published = true AND id != ?", @project.id).order(start_date: :desc).limit(6)
  end
end
