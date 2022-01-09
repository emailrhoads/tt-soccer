# frozen_string_literal: true

module Api
  module V1
    # allow users edit Teams via API
    class TeamsController < ApplicationController
      before_action :set_team, only: %i[show update]

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
        @team = Team.find_by(id: params[:id])
        no_such_team unless @team
      end

      # Only allow a list of trusted parameters through.
      def team_params
        params.require(:team).permit(:name, :country)
      end

      def no_such_team
        render json: { error: 'no such team' }, status: :not_found
      end
    end
  end
end
