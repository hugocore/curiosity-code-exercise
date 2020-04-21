# frozen_string_literal: true

class Crate < ApplicationRecord
  belongs_to :robot, optional: true
  belongs_to :warehouse
end
