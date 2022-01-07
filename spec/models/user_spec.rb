require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.new' do
    it 'requires a valid email address' do
      subject = described_class.new(
        email: 'badEmail@',
        password: 1234567890,
        password_confirmation: 1234567890
      )
      expect(subject.errors)
    end
  end
end
