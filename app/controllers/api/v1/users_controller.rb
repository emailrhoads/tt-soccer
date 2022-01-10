# frozen_string_literal: true

module Api
  module V1
    # allow users to register via API
    class UsersController < ApplicationController
      before_action :require_login, only: [:show]

      def show
        user = current_user
        team = user.team
        players = team.players
        user_attrs = user.attributes.except('crypted_password', 'salt')
        render json: { user: user_attrs, team: team, players: players }, status: :ok
      end

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

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
