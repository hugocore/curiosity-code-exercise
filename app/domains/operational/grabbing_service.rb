# frozen_string_literal: true

module Operational
  class GrabbingService
    include AutoInject['robots_repo']

    def call(robot:)
      return unless robot

      robots_repo.grab_crate(robot)
    end
  end
end