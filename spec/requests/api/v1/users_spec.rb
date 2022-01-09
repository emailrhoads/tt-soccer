# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/users', type: :request do
  let(:valid_attributes) do
    {
      email: 'john@toptal.com',
      password: 'ABCDefghijk',
      password_confirmation: 'ABCDefghijk'
    }
  end

  let(:invalid_attributes) do
    {
      email: 'john@',
      password: 'ABCDefghijk',
      password_confirmation: 'ABCDefghijk'
    }
  end

  let(:valid_headers) do
    {}
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post '/api/v1/register',
               params: { user: valid_attributes }, headers: valid_headers, as: :json
        end.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post '/api/v1/register',
             params: { user: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response_json.keys).to eq(%w[id email])
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'will create a team and players for the new user', :aggregate_failures do
        post '/api/v1/register',
             params: { user: valid_attributes }, headers: valid_headers, as: :json
        new_user_id = response_json['id']
        new_user = User.find(new_user_id)
        new_teams = new_user.teams
        expect(new_teams).to be_present
        expect(new_teams.first.players).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post '/api/v1/register',
               params: { user: invalid_attributes }, as: :json
        end.to change(User, :count).by(0)
      end

      it 'renders a JSON response with errors for the new user' do
        post '/api/v1/register',
             params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to a_string_including('application/json')
      end
    end
  end
end
