# frozen_string_literal: true

# These are our soccer players
class Player < ApplicationRecord
  INITIAL_MARKET_VALUE = 1_000_000

  belongs_to :team, dependent: :destroy

  validates :asking_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :age, presence: true
  validates :country, presence: true, inclusion: { in: Enum::Country::VALUES }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :market_value, presence: true, numericality: { greater_than_or_equal_to: INITIAL_MARKET_VALUE }
  validates :position, presence: true,
                       inclusion: {
                         in: Enum::Position::VALUES,
                         message: "%<value>s not in #{Enum::Position::VALUES}"
                       }

  before_validation :default_values

  scope :on_transfer_list, -> { where.not(asking_price: false) }

  def default_values
    self.market_value = INITIAL_MARKET_VALUE

    self.age ||= rand(18..40)
    self.country ||= Enum::Country::VALUES.sample
    self.first_name ||= Faker::Name.first_name
    self.last_name ||= Faker::Name.last_name
  end

  def self.trade(buying_team:, player: )
    raise 'Player not for sale' if player.asking_price.nil?
    raise 'Cannot purchase your own player' if player.team == buying_team
    raise 'Insufficient funds' if buying_team.balance < player.asking_price

    selling_team = player.team
    ActiveRecord::Base.transaction do
      update_trade_balances(buying_team, player, selling_team)
      update_player_attributes(buying_team, player)
    end

    true
  end

  class << self
    private

    # Add Player's asking price to selling team and remove from buying team
    def update_trade_balances(buying_team, player, selling_team)
      asking_price = player.asking_price
      selling_team.balance += asking_price
      buying_team.balance -= asking_price
    end

    # Change ownership of Player and make any trade-driven adjustments
    def update_player_attributes(buying_team, player)
      player.team = buying_team
      player.asking_price = nil # remove from market list

      # when a player is traded we increase their value by random amount
      pct_increase = rand(0.1..1.0)
      player.market_value = player.market_value * (1 + pct_increase)
    end
  end
end
