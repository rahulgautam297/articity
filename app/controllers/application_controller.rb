class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end









# Takes back to the same page after signing in
#  before_filter :store_current_location, :unless => :devise_controller?
#   def store_current_location
#     store_location_for(:user, request.url)
#   end
