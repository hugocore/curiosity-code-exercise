# frozen_string_literal: true

class RobotControlController < ApplicationController
  def control
    control_service.call(
      robot_id: control_params[:id],
      cardinal_points: commands
    )
  rescue Errors::RobotNotFound
    head(404)
  end

  private

  def commands
    control_params[:commands].gsub(' ', '').split('')
  end

  def control_params
    params.permit(:id, :commands)
  end

  def control_service
    Container['cardinal_directions_service']
  end
end
