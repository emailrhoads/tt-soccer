# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/teams', type: :request do
  fixtures :users
  fixtures :teams

  let(:team) { teams(:test_team) }
  let(:valid_headers) do 
    {}
  end

  describe 'POST /show', :focus do
    

    it 'will display a team for the user' do
      get "/api/v1/teams/#{team.id}", headers: valid_headers, as: :json
      expect(response_json).to eq(team.as_json)
    end

    xit 'will return an object not found if not corresponding team' do
      get "/api/v1/teams/0", headers: valid_headers, as: :json
    end
  end

  describe 'POST /update', :focus do
    let(:new_name) { 'my new name' }
    let(:new_country) { 'Angola' }

    let(:valid_attributes) do
      {
        name: new_name,
        country: new_country,
      }
    end

    context 'with valid parameters' do
      it 'can update the name and country' do
        patch "/api/v1/teams/#{team.id}",
          params: { team: valid_attributes }, headers: valid_headers, as: :json
        expect(team.reload.slice(:name, :country)).to eq(valid_attributes.stringify_keys)
      end

      it 'can not update budget or other restricted fields' do
        args_with_balance_adjustment = valid_attributes.merge({ balance: 1 })
        expect do 
          patch "/api/v1/teams/#{team.id}",
            params: { team: args_with_balance_adjustment }, headers: valid_headers, as: :json
        end.not_to change(team, :balance)
      end
    end

  end
end
