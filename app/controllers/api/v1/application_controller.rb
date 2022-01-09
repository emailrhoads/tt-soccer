# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      # FIXME: WE need CSRF protection? Or is this autofixed in Rails7?
      # protect_from_forgery with: :null_session

      # protect_from_forgery with: :exception

      def team_owner?
        @team.user == current_user
      end

      def confirm_authorized
        render_unauthorized_response unless authorized?
      end

      def render_unauthorized_response
        render json: { error: 'Access denied'}, status: :unauthorized
      end

      def check_login
        return if logged_in?

        render json: {error: 'You must login first'}, status: :unauthorized
      end
    end
  end
end
