# frozen_string_literal: true

module Api
  module V1
    # allow users edit Teams via API
    class TeamsController < ApplicationController
      before_action :require_login, only: %i[update]
      before_action :set_team, only: %i[show update]
      before_action :require_ownership, only: %i[update]

      def show
        # FIXME: do we want team and players to appear here? probably...
        render json: @team
      end

      def update
        if @team.update(team_params)
          render json: @team
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      # TODO: Should we add destroy so a user can restart the game if they want?

      private

      def set_team
        @team = Team.find_by(id: params[:id])
        no_such_team unless @team
      end

      def team_params
        params.require(:team).permit(:name, :country)
      end
    end
  end
end
