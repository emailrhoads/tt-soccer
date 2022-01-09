# frozen_string_literal: true

module Api
  module V1
    module Teams
      # interact with players on a team
      class PlayersController < ApplicationController
        before_action :set_team, only: %i[index show update]
        before_action :set_player, only: %i[show update]

        def index
          records = @team.players
          render json: records
        end

        def show
          render json: @player
        end

        def update
          if @player.update(player_params)
            render json: @player
          else
            render json: @player.errors, status: :unprocessable_entity
          end
        end

        private

        def set_player
          @player = Player.find(params[:id])
        end

        def set_team
          @team = Team.find(params[:team_id])
        end

        def player_params
          params.require(:player).permit(:first_name, :last_name, :country)
        end
      end
    end
  end
end
