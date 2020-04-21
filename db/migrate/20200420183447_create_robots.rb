# frozen_string_literal: true

class CreateRobots < ActiveRecord::Migration[6.0]
  def change
    create_table :robots do |t|
      t.integer :x
      t.integer :y
      t.references :warehouse, null: false, foreign_key: true

      t.timestamps
    end

    add_index :robots, %i[x y warehouse_id], unique: true
  end
end
