class ApplicationController < ActionController::API
  before_action :authenticate_request
  before_action :authorize_admin, only: :admin_dashboard

  def current_user
    @current_user ||= User.find_by_token(request.headers['Authorization'])
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    current_user.admin == "admin"
  end

  private

  def authenticate_request
    render json: { error: 'Unauthorized' }, status: :unauthorized unless logged_in?
  end

  def authorize_admin
    render json: { error: 'Unauthorized' }, status: :unauthorized unless admin?
  end
end
