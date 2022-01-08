# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.new' do
    it 'requires a valid email address' do
      subject = described_class.new(
        email: 'badEmail@',
        password: 1_234_567_890,
        password_confirmation: 1_234_567_890
      )
      expect(subject.errors)
    end
  end
end
