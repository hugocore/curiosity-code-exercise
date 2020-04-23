# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operational::OperationsService do
  subject(:operations_service) do
    described_class.new(
      grabbing_service: grabbing_service,
      dropping_service: dropping_service
    )
  end

  let(:grabbing_service) { instance_double Operational::GrabbingService, call: {} }
  let(:dropping_service) { instance_double Operational::DroppingService, call: {} }

  let(:robot) { create :robot }
  let(:commands) { %w[G D] }

  describe '#call' do
    context 'with an invalid robot_id' do
      it 'raises an error' do
        expect do
          operations_service.call(robot_id: 0, commands: commands)
        end.to raise_error Errors::RobotNotFound
      end
    end

    context 'when valid commands are given' do
      before { operations_service.call(robot_id: robot.id, commands: commands) }

      it 'delegates the grab command to the GrabbingService' do
        expect(grabbing_service).to have_received(:call).with(robot: robot)
      end

      it 'delegates the drop command to the DroppingService' do
        expect(dropping_service).to have_received(:call).with(robot: robot)
      end
    end

    context 'when no commands are given' do
      before { operations_service.call(robot_id: robot.id, commands: commands) }

      let(:commands) { [] }

      it 'does not delegates to the GrabbingService' do
        expect(grabbing_service).not_to have_received(:call)
      end

      it 'does not delegates to the DroppingService' do
        expect(dropping_service).not_to have_received(:call)
      end
    end
  end
end
