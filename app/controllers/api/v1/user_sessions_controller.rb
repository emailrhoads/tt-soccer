class Api::V1::UserSessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email], api_key: params[:api_key])
    auto_login(@user)


    if @user
      render json: {'status': 'Login successful'}, status: :ok
    else
      render json: {'status': 'Login failed'}, status: :unauthorized
    end
  end

  def destroy
    logout
    render json: {'status': 'Logged out'}, status: :ok
  end

  def user_sessions_params
    params.require(:api_key)
  end
end