# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :country, null: false
      t.string :name, null: false
      t.decimal :balance, null: false
      t.references :user, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
