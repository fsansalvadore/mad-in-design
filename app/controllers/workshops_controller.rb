class WorkshopsController < ApplicationController
  before_action :authenticate_admin_user!, only: [:index, :show, :prendersi_cura, :team]
  before_action :set_workshop, only: [:show]

  def index
    @workshops = Workshop.all
  end

  def show
  end

  def prendersi_cura
  end

  def team
  end

  private

  def set_workshop
    @workshop = Workshop.friendly.find_by_slug(params[:slug])
  end
end
