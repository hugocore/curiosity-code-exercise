# frozen_string_literal: true

class Warehouse < ApplicationRecord
  has_many :robots, dependent: :destroy
  has_many :crates, dependent: :destroy
end
