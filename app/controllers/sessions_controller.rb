class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      render json: { token: @user.generate_token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    # Log out the current user by setting the token to nil
    current_user.update(token: nil)

    render json: { message: 'Logged out successfully' }
  end
  
end
