# frozen_string_literal: true

class Warehouse < ApplicationRecord
  has_many :robots
  has_many :crates
end
