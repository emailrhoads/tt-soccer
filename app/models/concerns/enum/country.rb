class Enum::Country < ApplicationRecord
  self.abstract_class = true

  # FIXME: Migrate to Postgres and use types for these
  VALUES = CS.countries.map { |short, long| long }
end
