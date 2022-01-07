require 'rails_helper'

RSpec.describe "UserSessions", type: :request do
  fixtures :users

  let(:valid_login_params) do
    {
      email: users(:test_user).email,
      password: "supersecret",
    }
  end

  describe "GET /create" do
    context 'login fails' do
      it 'if user does not exist' do
        post "/api/v1/login", params: valid_login_params.merge(email: 'nobody@gmail.com')
        expect(response).to have_http_status(:unauthorized)
      end

      it 'if password is incorrect' do
        post "/api/v1/login", params: valid_login_params.merge(password: "bad")
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'login succeeds' do
      it "if given proper credentials" do
        binding.pry
        post "/api/v1/login", params: valid_login_params
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/logout"
      expect(response).to have_http_status(:success)
    end
  end

end
