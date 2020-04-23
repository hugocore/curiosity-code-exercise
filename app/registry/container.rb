# frozen_string_literal: true

class Container
  extend Dry::Container::Mixin

  register(:navigation_domain) { Navigation::CardinalDirections.new }

  register(:robots_repo) { Repositories::Robots::ActiveRecordAdaptor.new }
end
