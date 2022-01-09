# frozen_string_literal: true

module Api
  module V1
    # common methods for all API::V1 controllers
    class ApplicationController < ActionController::API
      # FIXME: WE need CSRF protection? Or is this autofixed in Rails7?
      # protect_from_forgery with: :null_session

      def require_ownership
        render_unauthorized_response unless @team.user == current_user
      end

      def render_unauthorized_response
        render json: { error: 'Access denied' }, status: :unauthorized
      end

      def not_authenticated
        render json: { error: 'You must login first' }, status: :unauthorized
      end
    end
  end
end
