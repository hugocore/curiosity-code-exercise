# frozen_string_literal: true

class Container
  extend Dry::Container::Mixin

  register(:commands_service) { Control::CommandsService.new }
  register(:navigation_service) { Navigation::CardinalDirectionsService.new }
  register(:operational_service) { Operational::OperationsService.new }
  register(:grabbing_service) { Operational::GrabbingService.new }
  register(:dropping_service) { Operational::DroppingService.new }

  register(:robots_repo) { Repositories::Robots::ActiveRecordAdaptor.new }
end
