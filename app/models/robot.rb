# frozen_string_literal: true

class Robot < ApplicationRecord
  has_one :crate, dependent: :nullify
  belongs_to :warehouse

  validate :location_is_inside_boundaries
  validate :location_is_available
  validates :warehouse, presence: true

  scope :in_location, ->(x, y, warehouse) { where(x: x, y: y, warehouse: warehouse) }
  scope :others_than, ->(robot) { where.not(id: robot.id) }

  def location_is_inside_boundaries
    error_location_outside = 'is not a positive location inside the warehouse'

    errors.add(:x, error_location_outside) unless x.between?(1, warehouse.width)
    errors.add(:y, error_location_outside) unless y.between?(1, warehouse.length)
  end

  def location_is_available
    error_location = 'Location is not available for the robot'

    errors[:base] << error_location if Robot.others_than(self).in_location(x, y, warehouse).exists?
  end

  def position
    [x, y]
  end
end
