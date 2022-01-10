class AddIndexOnPlayerMarketValueAndTeam < ActiveRecord::Migration[7.0]
  def change
    add_index :players, [:team_id, :market_value]
  end
end
