class Api::V1::UserSessionsController < ApplicationController
  def create
    @user = login(params[:email], params[:password])

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
end