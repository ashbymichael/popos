class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_current_location
    respond_to do |format|
      format.json { render json: grab_location }
      format.html {}
    end
  end

end
