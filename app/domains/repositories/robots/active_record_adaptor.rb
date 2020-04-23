# frozen_string_literal: true

module Repositories
  module Robots
    class ActiveRecordAdaptor < Repositories::Robots::Base
      def find_by(id:); end

      def up(robot, distance); end

      def down(robot, distance); end

      def right(robot, distance); end

      def left(robot, distance); end

      def save(robot); end
    end
  end
end
