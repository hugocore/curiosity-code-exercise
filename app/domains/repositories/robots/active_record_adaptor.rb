# frozen_string_literal: true

module Repositories
  module Robots
    class ActiveRecordAdaptor < Repositories::Robots::Base
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

      def save(robot)
        robot.save!
      end
    end
  end
end
