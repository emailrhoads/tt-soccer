class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :country
      t.string :name
      t.decimal :balance
      t.references :users

      t.timestamps
    end
  end
end
