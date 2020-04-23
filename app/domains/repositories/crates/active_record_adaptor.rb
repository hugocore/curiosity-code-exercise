# frozen_string_literal: true

module Repositories
  module Crates
    class ActiveRecordAdaptor < Base
      def find_by(id:)
        Crate.find_by(id: id)
      end
    end
  end
end
