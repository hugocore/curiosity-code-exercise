# frozen_string_literal: true

module Operational
  class DroppingService
    include AutoInject['robots_repo']

    def call(robot:)
      return unless robot

      robots_repo.drop_crate(robot)
    end
  end
end
