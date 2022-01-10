# frozen_string_literal: true

# common methods used in /spec/requests/
module RequestHelpers
  def expect_authorization_error
    expect(response.successful?).to eq(false)
    expect(response_json).to eq({ 'error' => 'Access denied' })
  end

  def expect_not_logged_in_error
    expect(response.successful?).to eq(false)
    expect(response_json).to eq({ 'error' => 'You must login first' })
  end

  # from https://github.com/Sorcery/sorcery/wiki/Testing-Rails
  def login(user, password = 'supersecret')
    # post the login and follow through
    # ensure that the password you set here conforms to what you have set in your
    # fixtures/factory.
    post api_v1_user_sessions_path, params: { email: user.email, password: password }
  end

  def response_json
    JSON.parse(@response.body)
  end
end
