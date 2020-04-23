# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operational::GrabbingService do
  subject(:drop_service) { described_class.new(robots_repo: repo) }

  let(:repo) do
    instance_double Repositories::Robots::Base,
                    grab_crate: nil,
                    holding_crate?: holding_crate?,
                    over_crate?: over_crate?
  end
  let(:robot) { build(:robot) }
  let(:holding_crate?) { false }
  let(:over_crate?) { true }

  describe '#call' do
    before { drop_service.call(robot: robot) }

    it 'calls the robots repository' do
      expect(repo).to have_received(:grab_crate).with(robot)
    end

    context 'without a robot' do
      let(:robot) { nil }

      it 'does not grab a crate' do
        expect(repo).not_to have_received(:grab_crate).with(robot)
      end
    end

    context 'with a robot already holding a crate' do
      let(:holding_crate?) { true }

      it 'does not grab a crate' do
        expect(repo).not_to have_received(:grab_crate).with(robot)
      end
    end

    context 'when the robot is not over a crate' do
      let(:over_crate?) { false }

      it 'does not grab a crate' do
        expect(repo).not_to have_received(:grab_crate).with(robot)
      end
    end
  end
end
