# frozen_string_literal: true

class Container
  extend Dry::Container::Mixin

  register(:cardinal_directions_service) { Navigation::CardinalDirectionsService.new }

  register(:robots_repo) { Repositories::Robots::ActiveRecordAdaptor.new }
end
