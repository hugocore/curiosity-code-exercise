# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_420_183_526) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'crates', force: :cascade do |t|
    t.integer 'x'
    t.integer 'y'
    t.bigint 'robot_id', null: false
    t.bigint 'warehouse_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['robot_id'], name: 'index_crates_on_robot_id'
    t.index ['warehouse_id'], name: 'index_crates_on_warehouse_id'
    t.index %w[x y robot_id], name: 'index_crates_on_x_and_y_and_robot_id', unique: true
    t.index %w[x y warehouse_id], name: 'index_crates_on_x_and_y_and_warehouse_id', unique: true
  end

  create_table 'robots', force: :cascade do |t|
    t.integer 'x'
    t.integer 'y'
    t.bigint 'warehouse_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['warehouse_id'], name: 'index_robots_on_warehouse_id'
    t.index %w[x y warehouse_id], name: 'index_robots_on_x_and_y_and_warehouse_id', unique: true
  end

  create_table 'warehouses', force: :cascade do |t|
    t.integer 'width'
    t.integer 'length'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'crates', 'robots'
  add_foreign_key 'crates', 'warehouses'
  add_foreign_key 'robots', 'warehouses'
end
