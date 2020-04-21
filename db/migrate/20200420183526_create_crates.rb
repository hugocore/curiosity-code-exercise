# frozen_string_literal: true

class CreateCrates < ActiveRecord::Migration[6.0]
  def change
    create_table :crates do |t|
      t.integer :x
      t.integer :y
      t.references :robot, null: true, foreign_key: true
      t.references :warehouse, null: false, foreign_key: true

      t.timestamps
    end

    add_index :crates, %i[x y warehouse_id], unique: true
    add_index :crates, %i[x y warehouse_id robot_id], unique: true
  end
end
