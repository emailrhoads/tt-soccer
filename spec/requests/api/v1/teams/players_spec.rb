# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/teams/<team.id>/players', type: :request do
  fixtures :users
  fixtures :teams
  fixtures :players

  let(:player) { players(:player1) }
  let(:team) { teams(:test_team) }
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'will display all players for a team' do
      get api_v1_team_players_url(team_id: team.id),
          headers: valid_headers, as: :json
      expect(response_json).to eq(team.players.as_json)
    end
  end

  describe 'GET /show' do
    it 'will display a player' do
      get api_v1_team_player_path(player, team_id: team.id),
          headers: valid_headers, as: :json
      expect(response_json).to eq(player.as_json)
    end
  end

  describe 'POST /update' do
    let(:valid_attributes) do
      {
        first_name: 'Fchanged',
        last_name: 'Lchanged',
        country: 'Angola',
        asking_price: 2_000_000
      }
    end

    context 'when not logged in' do
      it 'requires login' do
        patch api_v1_team_player_path(player, team_id: team.id),
              params: { player: valid_attributes }, headers: valid_headers, as: :json
        expect_not_logged_in_error
      end
    end

    context 'when logged in NOT as player owner' do
      before do
        non_owner_user = User.where.not(id: player.user.id).first
        login(non_owner_user)
      end

      it 'requires ownership' do
        patch api_v1_team_player_path(player, team_id: team.id),
              params: { player: valid_attributes }, headers: valid_headers, as: :json
        expect_authorization_error
      end
    end

    context 'when logged in as player owner' do
      before { login(player.user) }

      it 'can update allowed attributes' do
        patch api_v1_team_player_path(player, team_id: team.id),
              params: { player: valid_attributes }, headers: valid_headers, as: :json
        expect(player.reload.slice(valid_attributes.keys)).to eq(valid_attributes.stringify_keys)
      end

      it 'can not update market_value or other restricted fields' do
        args_with_balance_adjustment = valid_attributes.merge({ market_value: 1 })
        expect do
          patch api_v1_team_player_path(player, team_id: team.id),
                params: { player: args_with_balance_adjustment }, headers: valid_headers, as: :json
        end.not_to change(player, :market_value)
      end
    end
  end
end
