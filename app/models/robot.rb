# frozen_string_literal: true

class Robot < ApplicationRecord
  has_one :crate
  belongs_to :warehouse
end
