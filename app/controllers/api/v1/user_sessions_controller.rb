# frozen_string_literal: true

module Api
  module V1
    # allow users to login and logout via API
    class UserSessionsController < ApplicationController
      def create
        @user = login(params[:email], params[:password])

        if @user
          render json: { 'status': 'Login successful' }, status: :ok
        else
          render json: { 'status': 'Login failed' }, status: :unauthorized
        end
      end

      def show
        if logged_in?
          render json: { success: true, user: current_user }
        else
          render json: {
            error: true,
            error_message: 'No current session'
          }
        end
      end

      def destroy
        logout
        render json: { 'status': 'Logged out' }, status: :ok
      end

      def user_sessions_params
        params.require(:email, :password)
      end
    end
  end
end
