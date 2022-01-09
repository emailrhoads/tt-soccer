# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  fixtures :users
  fixtures :teams

  let(:team) { teams(:test_team) }
  let(:valid_position) { 'goalkeeper' }

  def create_valid_player(team_of_ownership = team)
    described_class.create(
      team: team_of_ownership,
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

  describe '#trade' do
    let(:asking_price) { 1 }
    let(:selling_team) { teams(:test_team) }
    let(:buying_team) { teams(:team1) }
    let(:player) { create_valid_player(selling_team) }

    before { player.update!(asking_price: asking_price) }

    it 'will return true if successful' do
      res = described_class.trade(buying_team: buying_team, player: player)
      expect(res).to eq(true)
    end

    context 'buying team' do
      it 'will not allow a trade if you already own the player' do
        expect do
          described_class.trade(buying_team: selling_team, player: player)
        end.to raise_error(/Cannot purchase your own player/)
      end

      it 'will not allow the trade if the team lacks sufficient funds' do
        player.update!(asking_price: buying_team.balance + 1)
        expect do
          described_class.trade(buying_team: buying_team, player: player)
        end.to raise_error(/Insufficient funds/)
      end

      it 'will decrease budget by players asking price' do
        expect do
          described_class.trade(buying_team: buying_team, player: player)
        end.to change(buying_team, :balance).by(-asking_price)
      end
    end

    context 'player' do
      it 'cannot be bought if not on the market list' do
        player.update!(asking_price: nil)
        expect do
          described_class.trade(buying_team: buying_team, player: player)
        end.to raise_error(/Player not for sale/)
      end

      it 'will transfer ownership of the player' do
        expect do
          described_class.trade(buying_team: buying_team, player: player)
        end.to change(player, :team).from(selling_team).to(buying_team)
      end

      it 'will increase the player market value' do
        expect do
          described_class.trade(buying_team: buying_team, player: player)
        end.to change(player, :market_value)
      end

      it 'will change player market_value by 10% and 100%' do
        before = player.market_value
        described_class.trade(buying_team: buying_team, player: player)
        after = player.reload.market_value
        expect(after).to be_between(0.1 * before, 1.0 * before)
      end
    end

    context 'selling_team' do
      it 'will decrease budget by players asking price' do
        expect do
          described_class.trade(buying_team: buying_team, player: player)
        end.to change(selling_team, :balance).by(asking_price)
      end
    end
  end
end
