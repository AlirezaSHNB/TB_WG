class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      render json: { token: @user.generate_token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end
