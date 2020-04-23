# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Control::CommandsService do
  subject(:control) do
    described_class.new(
      navigation_service: navigation_service,
      operational_service: operational_service
    )
  end

  let(:navigation_service) { instance_double Navigation::CardinalDirectionsService, call: {} }
  let(:operational_service) { instance_double Navigation::CardinalDirectionsService, call: {} }
  let(:robot) { create :robot }

  describe '#call' do
    context 'when navigation commands are passed' do
      let(:commands) { Navigation::Commands::ALL }

      before { control.call(robot_id: robot.id, commands: commands) }

      it 'delegates commands to the Navigation domain' do
        expect(navigation_service).to have_received(:call).exactly(commands.size).time
      end
    end

    context 'when operational commands are passed' do
      let(:commands) { Operational::Commands::ALL }

      before { control.call(robot_id: robot.id, commands: commands) }

      it 'delegates commands to the Operational domain' do
        expect(operational_service).to have_received(:call).exactly(commands.size).time
      end
    end

    context 'when all kinds of commands are passed' do
      let(:commands) { Navigation::Commands::ALL + Operational::Commands::ALL }

      before { control.call(robot_id: robot.id, commands: commands) }

      it 'delegates navigational commands to the Navigation domain' do
        expect(navigation_service)
          .to have_received(:call).exactly(Navigation::Commands::ALL.size).time
      end

      it 'delegates operational commands to the Operational domain' do
        expect(operational_service)
          .to have_received(:call).exactly(Operational::Commands::ALL.size).time
      end
    end

    context 'when no commands are passed' do
      let(:commands) { [] }

      before { control.call(robot_id: robot.id, commands: commands) }

      it 'does not delegates commands to the Navigation domain' do
        expect(navigation_service).not_to have_received(:call)
      end

      it 'does not delegates commands to the Operational domain' do
        expect(operational_service).not_to have_received(:call)
      end
    end

    context 'when only invalid commands are passed' do
      let(:commands) { ['#'] }

      it 'raises an error' do
        expect do
          control.call(robot_id: robot.id, commands: commands)
        end.to raise_error Errors::CommandNotSupported
      end
    end

    context 'when invalid commands are passed between valid commands' do
      let(:commands) { Navigation::Commands::ALL + ['#'] + Operational::Commands::ALL }

      before { control.call(robot_id: robot.id, commands: commands, raise_errors: false) }

      it 'delegates valids commands to the Navigation domain' do
        expect(navigation_service)
          .to have_received(:call).exactly(Navigation::Commands::ALL.size).time
      end

      it 'stops the sequence when invalid commands are passed' do
        expect(operational_service).not_to have_received(:call)
      end
    end
  end
end
