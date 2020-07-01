class ProjectsController < ApplicationController
  def index
    @projects = Project.where(published: true).order(start_date: :desc)
    @years = []
    @projects.filter {|project| @years << project.start_date.year}
    @years.uniq!

    if params[:y].present?
      if params[:y] == "all"
        @projects = Project.where(published: true).order(start_date: :desc)
      else
        @projects = Project.where("extract(year from start_date) = ? OR extract(year from start_date) = ?", params[:y], params[:y]).where(published: true).order(start_date: :desc)
      end
      @yearSelect = params[:y]
    else
      @projects = Project.where(published: true).order(start_date: :desc)
    end
  end

  def show
    @project = Project.friendly.find_by_slug(params[:slug])
    @sections = @project.project_content_sections.all.order(position: :asc)

    @suggestions = Project.where("published = true AND id != ?", @project.id).order(start_date: :desc).limit(3)
  end
end
