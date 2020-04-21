# frozen_string_literal: true

class CreateWarehouses < ActiveRecord::Migration[6.0]
  def change
    create_table :warehouses do |t|
      t.integer :width
      t.integer :length

      t.timestamps
    end
  end
end
