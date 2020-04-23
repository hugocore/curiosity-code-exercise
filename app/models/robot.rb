# frozen_string_literal: true

class Robot < ApplicationRecord
  has_one :crate, dependent: :nullify
  belongs_to :warehouse

  validate :location_is_inside_boundaries
  validates :warehouse, presence: true

  def location_is_inside_boundaries
    error_location_outside = 'is not a positive location inside the warehouse'

    errors.add(:x, error_location_outside) unless x.between?(1, warehouse.width)
    errors.add(:y, error_location_outside) unless y.between?(1, warehouse.length)
  end

  def position
    [x, y]
  end
end
