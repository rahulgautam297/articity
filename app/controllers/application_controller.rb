class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end  
end









# Takes back to the same page after signing in
#  before_filter :store_current_location, :unless => :devise_controller?
#   def store_current_location
#     store_location_for(:user, request.url)
#   end