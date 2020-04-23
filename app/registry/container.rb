# frozen_string_literal: true

class Container
  extend Dry::Container::Mixin

  register(:navigation_service) { Navigation::CardinalDirectionsService.new }
  register(:operational_service) { Navigation::CardinalDirectionsService.new }
  register(:commands_service) { Control::CommandsService.new }

  register(:robots_repo) { Repositories::Robots::ActiveRecordAdaptor.new }
end
