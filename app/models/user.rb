# frozen_string_literal: true

# These are our application users
class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :team

  validates :email, email: true
  validates :password, length: { minimum: 10 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  before_create :default_api_key
  after_create :seed_team_and_players

  # FIXME: Currently unused ... preferring sessions as we assume this is an API for front-end
  def default_api_key
    self.api_key = SecureRandom.uuid
  end

  def seed_team_and_players
    Team.seed(self)
  end
end
