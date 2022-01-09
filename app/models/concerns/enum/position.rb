# frozen_string_literal: true

module Enum
  # Valid positions for our players
  class Position < ApplicationRecord
    self.abstract_class = true

    VALUES = [
      'goalkeeper',
      'defender',
      'midfielder',
      'attacker'
    ].freeze
  end
end
