# frozen_string_literal: true

module Repositories
  module Robots
    class Base
      def find_by(*)
        raise 'Not implemented yet'
      end

      def up(_robot, _distance)
        raise 'Not implemented yet'
      end

      def down(_robot, _distance)
        raise 'Not implemented yet'
      end

      def left(_robot, _distance)
        raise 'Not implemented yet'
      end

      def right(_robot, _distance)
        raise 'Not implemented yet'
      end

      def save
        raise 'Not implemented yet'
      end
    end
  end
end
