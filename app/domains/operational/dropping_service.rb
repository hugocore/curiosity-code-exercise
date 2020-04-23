# frozen_string_literal: true

module Operational
  class DroppingService
    include AutoInject['robots_repo']

    def call(robot:)
      return unless robot

      return if robots_repo.over_crate?(robot)

      return unless robots_repo.holding_crate?(robot)

      robots_repo.drop_crate(robot)
    end
  end
end
