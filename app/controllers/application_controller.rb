class ApplicationController < ActionController::API

  def current_user
    @current_user ||= User.find_by_token(request.headers['Authorization'])
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    current_user.role == 'admin'
  end

  private

  def authenticate_request
    render json: { error: 'Unauthorized' }, status: :unauthorized unless logged_in?
  end
end
