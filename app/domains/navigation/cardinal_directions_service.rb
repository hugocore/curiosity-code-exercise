# frozen_string_literal: true

module Navigation
  class CardinalDirectionsService
    include AutoInject['robots_repo']

    def call(robot_id:, commands:)
      @robot = robots_repo.find_by(id: robot_id)

      raise Errors::RobotNotFound unless robot

      commands.each do |command|
        move_robot(command)
      end

      robots_repo.save(robot)
    end

    private

    attr_reader :robot

    def move_robot(command)
      case command
      when Commands::NORTH
        robots_repo.up(robot, 1)
      when Commands::SOUTH
        robots_repo.down(robot, 1)
      when Commands::EAST
        robots_repo.right(robot, 1)
      when Commands::WEST
        robots_repo.left(robot, 1)
      end
    end
  end
end
