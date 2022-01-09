class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.references :team, foreign_key: { to_table: :teams }, null: false

      t.integer :age, null: false
      t.decimal :asking_price
      t.string :country, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.decimal :market_value, null: false
      t.string :position, null: false
      
      t.timestamps
    end
  end
end
