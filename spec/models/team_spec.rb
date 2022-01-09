# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  fixtures :users
  fixtures :teams

  describe 'validations' do
    let(:valid_attributes) do
      teams(:test_team).attributes.except('id', 'created_at', 'updated_at')
    end

    it 'will create' do
      subject = described_class.create(valid_attributes)
      expect(subject).to be_valid
    end

    it 'requires a user' do
      subject = described_class.create(valid_attributes.except('user_id'))
      expect(subject).not_to be_valid
    end

    it 'requires a valid country' do
      subject = described_class.create(valid_attributes.merge('country' => 'Toptal'))
      expect(subject).not_to be_valid
    end

    it 'requires a name' do
      subject = described_class.create(valid_attributes.except('name'))
      expect(subject).not_to be_valid
    end

    it 'must have a balance >= 0' do
      subject = described_class.create(valid_attributes.merge(balance: -1))
      expect(subject).not_to be_valid
    end
  end

  describe '#seed', :focus do
    let(:user) { users(:test_user) }
    let(:player_count) do
      described_class.send(:player_position_seed_map).sum { |_pos, qty| qty }
    end

    it 'will create a team for a user' do
      allow(described_class).to receive(:player_position_seed_map).and_return({})

      res = described_class.seed(user)
      expect(res).to be_valid
    end

    it 'will create players for that team' do
      res = described_class.seed(user)
      expect(res.players.count).to eq(player_count)
    end
  end
end
