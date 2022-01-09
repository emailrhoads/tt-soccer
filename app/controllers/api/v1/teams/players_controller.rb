# frozen_string_literal: true

module Api
  module V1
    module Teams
      # interact with players on a team
      class PlayersController < ApplicationController
        before_action :set_team, only: %i[show update destroy]

        def show
          render json: @team
        end

        # PATCH/PUT /teams/1 or /teams/1.json
        def update
          if @team.update(team_params)
            render json: @team
          else
            render json: @team.errors, status: :unprocessable_entity
          end
        end

        # TODO: Should we add destroy so a user can restart the game if they want?

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_team
          @team = Team.find(params[:team_id])
        end

        # Only allow a list of trusted parameters through.
        def team_params
          params.require(:team).permit(:name, :country)
        end
      end
    end
  end
end
