# frozen_string_literal: true

class RobotNavigationController < ApplicationController
  before_action :validate_directions, only: [:move]

  def move
    cardinal_directions_service.call(
      robot_id: robot_move_params[:id],
      cardinal_points: cardinal_points
    )
  rescue Navigation::RobotNotFound
    head(404)
  end

  private

  def validate_directions
    head(400) if robot_move_params[:directions].match(/[^NSEW ]/)
  end

  def cardinal_points
    robot_move_params[:directions].gsub(' ', '').split('')
  end

  def robot_move_params
    params.permit(:id, :directions)
  end

  def cardinal_directions_service
    Container['cardinal_directions_service']
  end
end
