# frozen_string_literal: true

module Repositories
  module Robots
    class ActiveRecordAdaptor < Base
      def find_by(id:)
        Robot.find_by(id: id)
      end

      def up(robot, distance)
        robot.y += distance
      end

      def down(robot, distance)
        robot.y -= distance
      end

      def right(robot, distance)
        robot.x += distance
      end

      def left(robot, distance)
        robot.x -= distance
      end

      def grab_crate(robot)
        crate = Crate.in_location(robot.x, robot.y, robot.warehouse).first

        robot.crate = crate
      end

      def drop_crate(robot)
        robot.crate.x = robot.x
        robot.crate.y = robot.y
        robot.crate = nil
      end

      def holding_crate?(robot); end

      def save(robot)
        robot.save!
      end
    end
  end
end
