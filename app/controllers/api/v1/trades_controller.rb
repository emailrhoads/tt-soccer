# frozen_string_literal: true

module Api
  module V1
    # transfer list and trading controller
    class TradesController < ApplicationController
      before_action :set_player, only: %i[create]

      def create
        # lookup user
        # lookup team

        result = Player.trade(buying_team: Team.first, player: @player)
        render json: result
      rescue StandardError => e
        render json: { error: e }, status: :unprocessable_entity
      end

      private

      def set_player
        @player = Player.find_by(id: params[:player_id])
        invalid_player unless @player
      end

      def invalid_player
        render json: { error: "No player with id #{params[:player_id]}" }, status: :unprocessable_entity
      end
    end
  end
end
