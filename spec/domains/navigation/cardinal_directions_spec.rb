# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Navigation::CardinalDirections do
  subject(:navigate) { described_class.new(robots_repo: repo) }

  let(:repo) { Repositories::Robots::ActiveRecordAdaptor.new }
  let(:warehouse) { create :warehouse, width: 10, length: 10 }
  let(:robot) { create :robot, x: x, y: y, warehouse: warehouse }
  let(:x) { 1 }
  let(:y) { 1 }

  describe '#call' do
    before { navigate.call(robot_id: robot.id, cardinal_points: cardinal_points) }

    context 'when all cardinal directions are given' do
      let(:cardinal_points) { %w[N E S W] }

      it 'moves the robot in a circle' do
        expect(robot.reload.position).to eq([1, 1])
      end
    end

    context 'when the cardinal directions zig zag' do
      let(:cardinal_points) { %w[N E N E N E N E] }

      it 'moves the robot to the center of the warehouse' do
        expect(robot.reload.position).to eq([5, 5])
      end
    end

    context 'when a cardinal directions is invalid' do
      let(:cardinal_points) { %w[A] }

      it 'keeps the robot in the same place' do
        expect(robot.reload.position).to eq([1, 1])
      end
    end
  end
end
