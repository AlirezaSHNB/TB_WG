class AdminController < ApplicationController
  def dashboard
    render json: { message: 'Admin Dashboard' }
  end
end
