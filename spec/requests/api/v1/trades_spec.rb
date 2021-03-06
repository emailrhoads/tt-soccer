# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/trades', type: :request do
  fixtures :users
  fixtures :teams
  fixtures :players

  let(:base_url) { '/api/v1/trades' }
  let(:player) { players.first }
  let(:team) { teams(:test_team) }
  let(:valid_headers) do
    {}
  end

  def put_players_on_transfer_list
    players.first(2).each { |p| p.update!(asking_price: 10) }
  end

  describe 'POST /api/v1/trades' do
    let(:valid_params) do
      {
        player_id: player.id
      }
    end

    let(:invalid_params) do
      {
        player_id: -1
      }
    end

    context 'when logged in' do
      before { login(team.user) }

      it 'will not work if invalid player id' do
        expect(Player).not_to receive(:trade)
        post base_url, params: invalid_params, headers: valid_headers, as: :json
        expect(response.successful?).to eq(false)
        expect(response_json.keys).to include('error')
      end

      it 'will create and execute a new trade' do
        put_players_on_transfer_list
        expect(Player).to receive(:trade).with({ buying_team: team, player: player })
        post base_url, params: valid_params, headers: valid_headers, as: :json
      end

      it 'will gracefully handle an error scenario' do
        put_players_on_transfer_list
        team.update!(balance: 0)
        post base_url, params: valid_params, headers: valid_headers, as: :json
        expect(response.successful?).to eq(false)
      end
    end

    it 'will not work if user is not logged in' do
      post base_url, params: valid_params, headers: valid_headers, as: :json
      expect_not_logged_in_error
    end
  end
end
