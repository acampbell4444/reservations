class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  protect_from_forgery with: :exception

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  #def after_sign_in_path_for(*args)
  #  current_user
#  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :firstname << :access
    devise_parameter_sanitizer.for(:account_update) << :firstname << :access
    devise_parameter_sanitizer.for(:sign_up) << :lastname << :access
    devise_parameter_sanitizer.for(:account_update) << :lastname << :access
  end


end
