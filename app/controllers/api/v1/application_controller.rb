# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      # FIXME: WE need CSRF protection? Or is this autofixed in Rails7?
      # protect_from_forgery with: :null_session
    end
  end
end
