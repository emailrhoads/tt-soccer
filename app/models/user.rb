# frozen_string_literal: true

# These are our application users
class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, email: true
  validates :password, length: { minimum: 10 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :teams

  before_create :default_api_key
  # after_create :create_team_and_players

  def default_api_key
    self.api_key = SecureRandom.uuid
  end

  def create_team_and_players
    _team = Team.seed(self)
    # Player.seed_for_team(team)
  end
end
