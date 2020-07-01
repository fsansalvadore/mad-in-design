class PagesController < ApplicationController
  before_action :authenticate_admin_user!, except: [:temporary]
  def home
    @projects = Project.where(published: true).order(start_date: :desc).limit(3)
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
