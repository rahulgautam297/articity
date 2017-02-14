class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :redirect_subdomain

  def redirect_subdomain
    if request.host[0..3] == 'www.'
      redirect_to request.host[4..request.host.length] + request.fullpath, :status => 301
    end
  end
end









# Takes back to the same page after signing in
#  before_filter :store_current_location, :unless => :devise_controller?
#   def store_current_location
#     store_location_for(:user, request.url)
#   end
