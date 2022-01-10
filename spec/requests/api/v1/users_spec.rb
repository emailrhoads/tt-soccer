# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/users', type: :request do
  fixtures :users
  fixtures :teams
  fixtures :players

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

  describe 'GET /index' do
    let(:user) { users(:test_user) }

    context 'when NOT logged in' do
      it 'throws a login required error' do
        get "/api/v1/users/#{user.id}", headers: valid_headers, as: :json
        expect_not_logged_in_error
      end
    end

    context 'when logged in' do
      before { login(user) }

      it 'shows team and players', :focus do
        get "/api/v1/users/#{user.id}", headers: valid_headers, as: :json
        expect(response_json.keys).to eq(%w[user team players])
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post '/api/v1/register',
               params: { user: valid_attributes }, headers: valid_headers, as: :json
        end.to change(User, :count).by(1)
      end

      it 'will log the user in' do
        expect_any_instance_of(Api::V1::UsersController).to receive(:auto_login)
        post '/api/v1/register',
             params: { user: valid_attributes }, headers: valid_headers, as: :json
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
        new_team = new_user.team
        expect(new_team).to be_present
        expect(new_team.players).to be_present
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
