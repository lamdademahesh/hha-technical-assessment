class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActionController::RoutingError, with: :render_not_found_json

  # Return 404 error for JSON requests
  def render_not_found_json(exception)
    render json: { error: "Invalid route" }, status: 404
  end

  # Raise routing error for unmatched routes
  def route_not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end
end
