# frozen_string_literal: true

class RobotControlController < ApplicationController
  def control
    commands_service.call(
      robot_id: control_params[:id],
      commands: commands
    )
  rescue Errors::RobotNotFound
    head(404)
  rescue Errors::CommandNotSupported
    head(400)
  end

  private

  def commands
    control_params[:commands].gsub(' ', '').split('')
  end

  def control_params
    params.permit(:id, :commands)
  end

  def commands_service
    Container['commands_service']
  end
end
