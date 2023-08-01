class AdminController < ApplicationController
  before_action :authenticate_request
  before_action :authorize_admin

  def dashboard
    render json: { message: 'Admin Dashboard' }
  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Unauthorized' unless admin?
  end
end
