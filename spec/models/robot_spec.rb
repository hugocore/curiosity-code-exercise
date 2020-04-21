# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Robot, type: :model do
  subject(:robot) { create :robot, x: x, y: y, warehouse: warehouse }

  let(:x) { 1 }
  let(:y) { 1 }
  let(:warehouse) { create :warehouse, width: 10, length: 10 }

  it { is_expected.to have_attributes(x: 1) }
  it { is_expected.to have_attributes(y: 1) }
  it { is_expected.to have_attributes(crate: nil) }

  context 'when placed to the bottom of the boundaries' do
    let(:y) { rand(-10..0) }

    it 'errors when put outside the grid' do
      expect { robot }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context 'when placed to the left of the boundaries' do
    let(:x) { rand(-10..0) }

    it 'errors when put outside the grid' do
      expect { robot }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context 'when placed to the right of the boundaries' do
    let(:x) { rand(warehouse.width + 1..warehouse.width + 10) }

    it 'errors when put outside the grid' do
      expect { robot }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context 'when placed to the top of the boundaries' do
    let(:y) { rand(warehouse.width + 1..warehouse.width + 10) }

    it 'errors when put outside the grid' do
      expect { robot }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context 'when grabbing a crate' do
    subject(:robot) { create :robot, :holding_crate, x: x, y: y, warehouse: warehouse }

    it 'checks that the crate and robot x position match' do
      expect(robot.x).to eq(robot.crate.x)
    end

    it 'checks that the crate and robot y position match' do
      expect(robot.y).to eq(robot.crate.y)
    end

    it 'checks that the crate and the robot are in the same warehouse' do
      expect(robot.warehouse).to eq(robot.crate.warehouse)
    end
  end
end
