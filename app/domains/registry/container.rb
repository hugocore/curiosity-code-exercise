# frozen_string_literal: true

module Registry
  class Container
    extend Dry::Container::Mixin

    register(:robots_repo) { Repositories::Robots::ActiveRecordAdaptor.new }
  end
end
