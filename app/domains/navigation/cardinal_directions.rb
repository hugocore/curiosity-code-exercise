# frozen_string_literal: true

module Navigation
  class CardinalDirections
    include AutoInject['robots_repo']

    CARDINAL_POINT_NORTH = 'N'
    CARDINAL_POINT_SOUTH = 'S'
    CARDINAL_POINT_EAST = 'E'
    CARDINAL_POINT_WEST = 'W'

    def call(robot_id:, cardinal_points:)
      @robot = robots_repo.find_by(id: robot_id)

      cardinal_points.each do |cardinal_point|
        move_robot(cardinal_point)
      end

      robots_repo.save(robot)
    end

    private

    attr_reader :robot

    def move_robot(cardinal_point)
      case cardinal_point
      when CARDINAL_POINT_NORTH
        robots_repo.up(robot, 1)
      when CARDINAL_POINT_SOUTH
        robots_repo.down(robot, 1)
      when CARDINAL_POINT_EAST
        robots_repo.right(robot, 1)
      when CARDINAL_POINT_WEST
        robots_repo.left(robot, 1)
      end
    end
  end
end
