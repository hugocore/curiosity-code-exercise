# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Crate, type: :model do
  subject(:crate) { create :crate, x: x, y: y, warehouse: warehouse }

  let(:x) { 1 }
  let(:y) { 1 }
  let(:warehouse) { create :warehouse, width: 10, length: 10 }

  it { is_expected.to have_attributes(x: 1) }
  it { is_expected.to have_attributes(y: 1) }
  it { is_expected.to have_attributes(robot: nil) }

  context 'when placed to the bottom of the boundaries' do
    let(:y) { rand(-10..0) }

    it 'errors when put outside the grid' do
      expect { crate }.to raise_error ActiveRecord::RecordInvalid, /not a positive location inside/
    end
  end

  context 'when placed to the left of the boundaries' do
    let(:x) { rand(-10..0) }

    it 'errors when put outside the grid' do
      expect { crate }.to raise_error ActiveRecord::RecordInvalid, /not a positive location inside/
    end
  end

  context 'when placed to the right of the boundaries' do
    let(:x) { rand(warehouse.width + 1..warehouse.width + 10) }

    it 'errors when put outside the grid' do
      expect { crate }.to raise_error ActiveRecord::RecordInvalid, /not a positive location inside/
    end
  end

  context 'when placed to the top of the boundaries' do
    let(:y) { rand(warehouse.width + 1..warehouse.width + 10) }

    it 'errors when put outside the grid' do
      expect { crate }.to raise_error ActiveRecord::RecordInvalid, /not a positive location inside/
    end
  end

  context 'when grabbed by robot' do
    subject(:crate) { create :crate, :grabbed, x: x, y: y, warehouse: warehouse }

    it 'checks that the crate and robot x position match' do
      expect(crate.x).to eq(crate.robot.x)
    end

    it 'checks that the crate and robot y position match' do
      expect(crate.y).to eq(crate.robot.y)
    end

    it 'checks that the crate and the robot are in the same warehouse' do
      expect(crate.warehouse).to eq(crate.robot.warehouse)
    end
  end

  context 'when another crate is already in the location' do
    subject(:crate) { create :crate, x: x, y: y, warehouse: warehouse }

    before { create(:crate, x: x, y: y, warehouse: warehouse) }

    it 'errors when the location is not available' do
      expect { crate }.to raise_error ActiveRecord::RecordInvalid, /Location is not available/
    end
  end
end
