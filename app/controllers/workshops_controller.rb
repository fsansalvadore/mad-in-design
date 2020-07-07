class WorkshopsController < ApplicationController
  before_action :authenticate_admin_user!, only: [:index, :show, :prendersi_cura, :team]
  before_action :set_workshop, only: [:show]

  def index
    @workshops = Workshop.where(published: true).order(start_date: :desc)
  end

  def show
    @outcomes = @workshop.workshop_outcomes.where(visible: true).order(position: :asc)

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
