# frozen_string_literal: true

# A team of soccer players
class Team < ApplicationRecord
  BEGINNING_BALANCE = 5_000_000

  belongs_to :user, dependent: :destroy
  has_many :players, dependent: :destroy

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :country, presence: true, inclusion: { in: Enum::Country::VALUES }
  validates :name, presence: true
  


  # Used to create a new team when a user registers
  def self.seed(user)
    team = create!(
      user: user,
      balance: BEGINNING_BALANCE,
      country: Enum::Country::VALUES.sample,
      name: Faker::Team.creature.titleize
    )

    # seed players
    player_position_seed_map.each do |position, seed_quantity|
      seed_quantity.times { Player.create!(team: team, position: position) }
    end

    team
  end

  class << self
    private

    def player_position_seed_map
      {
        # position: seed quantity
        goalkeeper: 3,
        defender: 6,
        midfielder: 6,
        attacker: 5,
      }
    end
  end
end
