class PagesController < ApplicationController
  before_action :authenticate_admin_user!, except: [:temporary]
  def home
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
