# frozen_string_literal: true

class Crate < ApplicationRecord
  belongs_to :robot, optional: true
  belongs_to :warehouse

  validate :location_is_inside_boundaries
  validate :location_is_available
  validates :warehouse, presence: true

  scope :in_location, ->(x, y, warehouse) { where(x: x, y: y, warehouse: warehouse) }
  scope :others_than, ->(crate) { where.not(id: crate.id) }

  def location_is_inside_boundaries
    error_location_outside = 'is not a positive location inside the warehouse'

    errors.add(:x, error_location_outside) unless x.between?(1, warehouse.width)
    errors.add(:y, error_location_outside) unless y.between?(1, warehouse.length)
  end

  def location_is_available
    error_location = 'Location is not available for the crate'

    errors[:base] << error_location if Crate.others_than(self).in_location(x, y, warehouse).exists?
  end
end
