# frozen_string_literal: true

class AddIndexOnPlayerMarketValueAndTeam < ActiveRecord::Migration[7.0]
  def change
    add_index :players, %i[team_id market_value]
  end
end
