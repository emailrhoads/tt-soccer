# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/transfer_list', type: :request do
  fixtures :users
  fixtures :teams
  fixtures :players

  let(:base_url) { '/api/v1/transfer_list' }
  let(:team) { teams(:test_team) }
  let(:valid_headers) do
    {}
  end

  def put_players_on_transfer_list
    players.first(2).each { |p| p.update!(asking_price: 1) }
  end

  describe 'GET /api/v1/transfer_list' do
    it 'will display players on the transfer_list' do
      put_players_on_transfer_list
      get base_url, headers: valid_headers, as: :json
      expect(response_json).to eq(Player.on_transfer_list.as_json)
    end

    it 'will return an empty array if nobody is on the xfer list' do
      get base_url, headers: valid_headers, as: :json
      expect(response_json).to eq([])
    end
  end
end
