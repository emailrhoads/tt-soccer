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
        message: "%{value} not in #{Enum::Position::VALUES}",
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

    def self.trade(buying_team, player)
      raise "Cannot purchase your own player" if player.team == buying_team

      # FIXME: do we need this guard, will validations do it for us anyway?
      raise "Insufficient funds" if buying_team.balance - player.asking_price < 0

      ActiveRecord::Base.transaction do
        # update balances to reflect trade
        player.team.balance =+ player.asking_price
        buying_team.balance = buying_team.balance - player.asking_price

        # update player with new team/after trade adjustments
        player.team = buying_team
        player.asking_price = nil # remove from waivers once traded
        player.market_value = player.market_value * (1 + rand(10..100))
      end
    end

end
