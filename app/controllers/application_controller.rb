class ApplicationController < ActionController::Base
  # before_action :authenticate_admin_user!

  def set_admin_locale
    I18n.locale = :it
  end
end
