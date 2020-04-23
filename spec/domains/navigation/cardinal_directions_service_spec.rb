# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Navigation::CardinalDirectionsService do
  subject(:navigation_service) { described_class.new(robots_repo: repo) }

  let(:repo) { Repositories::Robots::ActiveRecordAdaptor.new }
  let(:warehouse) { create :warehouse, width: 10, length: 10 }
  let(:robot) { create :robot, x: x, y: y, warehouse: warehouse }
  let(:x) { 1 }
  let(:y) { 1 }

  describe '#call' do
    context 'when robot does not exists' do
      let(:commands) { %w[G D] }

      it 'raises an error' do
        expect do
          navigation_service.call(robot_id: 0, commands: commands)
        end.to raise_error Errors::RobotNotFound
      end
    end

    context 'when all valid commands are given' do
      before { navigation_service.call(robot_id: robot.id, commands: commands) }

      let(:commands) { %w[N E S W] }

      it 'moves the robot in a circle' do
        expect(robot.reload.location).to eq([1, 1])
      end
    end

    context 'when the commands zig zag' do
      before { navigation_service.call(robot_id: robot.id, commands: commands) }

      let(:commands) { %w[N E N E N E N E] }

      it 'moves the robot to the center of the warehouse' do
        expect(robot.reload.location).to eq([5, 5])
      end
    end

    context 'when a commands is invalid' do
      before { navigation_service.call(robot_id: robot.id, commands: commands) }

      let(:commands) { %w[A] }

      it 'keeps the robot in the same place' do
        expect(robot.reload.location).to eq([1, 1])
      end
    end
  end
end
