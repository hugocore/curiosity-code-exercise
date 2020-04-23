# frozen_string_literal: true

module Operational
  class OperationsService
    include AutoInject['robots_repo']
    include AutoInject['grabbing_service']
    include AutoInject['dropping_service']

    def call(robot_id:, commands:)
      @robot = robots_repo.find_by(id: robot_id)

      raise Errors::RobotNotFound unless robot

      commands.each do |command|
        operate_robot(command)
      end

      robots_repo.save(robot)
    end

    private

    attr_reader :robot

    def operate_robot(command)
      case command
      when Commands::GRAB
        grabbing_service.call(robot: robot)
      when Commands::DROP
        dropping_service.call(robot: robot)
      end
    end
  end
end
