class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, email: true
  validates :password, length: { minimum: 10 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  before_create :default_api_key

  def default_api_key
    self.api_key ||= SecureRandom.uuid
  end
end
