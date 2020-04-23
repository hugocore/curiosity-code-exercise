# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operational::DroppingService do
  subject(:drop_service) { described_class.new(robots_repo: repo) }

  let(:repo) do
    instance_double Repositories::Robots::Base,
                    drop_crate: nil,
                    holding_crate?: holding_crate?,
                    over_crate?: over_crate?
  end
  let(:robot) { build(:robot) }
  let(:holding_crate?) { true }
  let(:over_crate?) { false }

  describe '#call' do
    before { drop_service.call(robot: robot) }

    it 'tells the robot to drop the crate' do
      expect(repo).to have_received(:drop_crate).with(robot)
    end

    context 'without a robot' do
      let(:robot) { nil }

      it 'does not tells the robot to drop the crate' do
        expect(repo).not_to have_received(:drop_crate).with(robot)
      end
    end

    context 'with a robot not holding a crate' do
      let(:holding_crate?) { false }

      it 'does not tell the robot to drop the crate' do
        expect(repo).not_to have_received(:drop_crate).with(robot)
      end
    end

    context 'when the robot is over a crate' do
      let(:over_crate?) { true }

      it 'does not tells the robot to drop the crate' do
        expect(repo).not_to have_received(:drop_crate).with(robot)
      end
    end
  end
end
