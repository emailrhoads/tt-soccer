# frozen_string_literal: true

module Api
  module V1
    # allow users to regisert via API
    class UsersController < ApplicationController
      # POST /users
      def create
        @user = User.new(user_params)

        if @user.save
          auto_login(@user)
          render json: @user.slice(:id, :email), status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def auto_login_user; end

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
