# frozen_string_literal: true

module Api
  module V1
    # transfer list and trading controller
    class TradesController < ApplicationController
      before_action :require_login, only: [:create]
      before_action :set_player, only: %i[create]

      def create
        team = current_user.team
        result = Player.trade(buying_team: team, player: @player)
        render json: result
      rescue StandardError => e
        render json: { error: e }, status: :unprocessable_entity
      end

      private

      def set_player
        @player = Player.find_by(id: params[:player_id])
        no_such_player unless @player
      end
    end
  end
end
