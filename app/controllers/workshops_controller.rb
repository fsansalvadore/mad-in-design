class WorkshopsController < ApplicationController
  # before_action :authenticate_admin_user!, only: [:index, :show, :prendersi_cura, :team]
  before_action :set_workshop, only: [:show, :team_workshop_team]

  def index
    @workshops = Workshop.where(published: true).order(start_date: :desc)
  end

  def show
    @outcomes = @workshop.workshop_outcomes.where(visible: true).order(position: :asc)
    typology = request.original_url.split("/")[5]
    if typology == "n"
      render :show
    else
      @teams = WorkshopTeam.where(workshop: @workshop).order(position: :asc)
      render :team_workshop
    end
  end

  def team_workshop_team
    @team = WorkshopTeam.find_by_title(params[:title])
    @outcomes = TeamOutcome.where(workshop_team: @team).order(position: :asc)
    @teams = WorkshopTeam.where(workshop: @workshop).order(position: :asc)
  end

  def prendersi_cura
  end

  def team_1_giornata_1

  end

  def team_1_b
  end

  def team
  end

  private

  def set_workshop
    @workshop = Workshop.friendly.find_by_slug(params[:slug])
  end
end
