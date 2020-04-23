# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operational::DroppingService do
  subject(:drop_service) { described_class.new(robots_repo: repo) }

  let(:repo) { instance_double Repositories::Robots::Base, drop_crate: nil }
  let(:robot) { create :robot }

  describe '#call' do
    before { drop_service.call(robot: robot) }

    it 'calls the robots repository' do
      expect(repo).to have_received(:drop_crate).with(robot)
    end

    context 'without a robot' do
      let(:robot) { nil }

      it 'does not call the robots repository' do
        expect(repo).not_to have_received(:drop_crate).with(robot)
      end
    end
  end
end
