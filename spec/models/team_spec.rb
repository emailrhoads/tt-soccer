# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  fixtures :users
  fixtures :teams

  describe 'validations' do
    let(:valid_attributes) do
      teams(:test_team).attributes.except('id', 'created_at', 'updated_at')
    end

    it 'requires a user', :focus do
      subject = described_class.new(valid_attributes.except('user_id'))
      expect(subject).not_to be_valid
    end

    it 'requires a valid country' do
      subject = described_class.new(valid_attributes.merge('country' => 'Toptal'))
      expect(subject).not_to be_valid
    end

    it 'requires a name' do
      subject = described_class.new(valid_attributes.except('name'))
      expect(subject).not_to be_valid
    end

    it 'must have a balance >= 0' do
      subject = described_class.new(valid_attributes.merge(balance: -1))
      expect(subject).not_to be_valid
    end
  end
end
