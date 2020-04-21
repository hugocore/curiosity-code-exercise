# frozen_string_literal: true

class Robot < ApplicationRecord
  has_one :crate, dependent: :nullify
  belongs_to :warehouse
end
