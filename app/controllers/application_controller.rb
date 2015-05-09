class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_catalog

  private

  def set_catalog
    @catalogs = Catalog.all
  end

  def after_sign_in_path_for(resource)
    if current_user.admin
      request.env['omniauth.origin'] || stored_location_for(resource) || admin_catalogs_path
    else
      sign_out current_user
      root_path
    end
  end
end
