class PagesController < ApplicationController
  # before_action :authenticate_admin_user!, except: [:temporary]
  def home
    @home = HomePage.all.first
    @workshop = Workshop.where(published: true).order(start_date: :desc).first
    @projects = Project.where(published: true).order(start_date: :desc).limit(2)
  end

  def about
  end

  def contacts
  end

  def privacy
  end

  def temporary
     render :layout => 'landing'
  end
end
