# frozen_string_literal: true

# A team of soccer players
class Team < ApplicationRecord
  BEGINNING_BALANCE = 5_000_000

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :country, presence: true, inclusion: { in: Enum::Country::VALUES }
  validates :name, presence: true
  belongs_to :user, dependent: :destroy

  # Used to create a new team when a user registers
  def self.seed(user)
    create!(
      user: user,
      balance: BEGINNING_BALANCE,
      name: "#{user.email}'s Team",
      country: Enum::Country::VALUES.sample
    )
  end
end
