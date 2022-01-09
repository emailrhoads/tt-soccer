# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  fixtures :users
  fixtures :teams

  let(:team) { teams(:test_team) }
  let(:valid_position) { 'goalkeeper' }

  def create_valid_player
    described_class.create(
      team: team,
      position: valid_position
    )
  end

  describe 'validations' do
    it 'requires a valid position value' do
      subject = described_class.create(
        team: team,
        position: 'Coach'
      )
      expect(subject.errors[:position].first).to match(/Coach not in/)
    end

    it 'does not require asking_price to be set' do
      subject = create_valid_player
      expect(subject.errors[:asking_price]).to be_empty
    end

    it 'sets a default market value' do
      subject = create_valid_player
      expect(subject.market_value).to eq(Player::INITIAL_MARKET_VALUE)
    end
  end

  describe '.default_values' do
    it 'will default various fields', :aggregate_failures do
      subject = create_valid_player
      presence_checks = %i[age first_name last_name country]
      presence_checks.each do |field|
        expect(subject.send(field)).to be_present
      end
    end
  end
end
