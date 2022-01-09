# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/teams', type: :request do
  fixtures :users
  fixtures :teams

  let(:base_url) { "/api/v1/teams/#{team.id}" }
  let(:team) { teams(:test_team) }
  let(:valid_headers) do
    {}
  end

  describe 'POST /show' do
    it 'will display a team for the user' do
      get base_url, headers: valid_headers, as: :json
      expect(response_json).to eq(team.as_json)
    end

    it 'will return an object not found if not corresponding team', :focus do
      get "/api/v1/teams/99999999" , headers: valid_headers, as: :json
      expect(response.successful?).to eq(false)
    end
  end

  describe 'POST /update' do
    let(:new_name) { 'my new name' }
    let(:new_country) { 'Angola' }

    let(:valid_attributes) do
      {
        name: new_name,
        country: new_country
      }
    end

    context 'when not logged in' do
      it 'requires user to be logged in' do
        

      end
    end

    context 'with valid parameters' do
      it 'can update the name and country' do
        patch base_url,
              params: { team: valid_attributes }, headers: valid_headers, as: :json
        expect(team.reload.slice(valid_attributes.keys)).to eq(valid_attributes.stringify_keys)
      end

      it 'can not update budget or other restricted fields' do
        args_with_balance_adjustment = valid_attributes.merge({ balance: 1 })
        expect do
          patch base_url,
                params: { team: args_with_balance_adjustment }, headers: valid_headers, as: :json
        end.not_to change(team, :balance)
      end
    end
  end
end
