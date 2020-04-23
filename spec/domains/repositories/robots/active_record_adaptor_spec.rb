# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::Robots::ActiveRecordAdaptor do
  subject(:repo) { described_class.new }

  let(:warehouse) { create :warehouse }
  let(:robot) { create :robot, x: x, y: y, warehouse: warehouse }
  let(:x) { 1 }
  let(:y) { 1 }

  describe '#find_by_id' do
    it 'finds the robot by ID' do
      expect(repo.find_by(id: robot.id)).to eq(robot)
    end

    context 'with an invalid ID' do
      it 'finds the robot by ID' do
        expect(repo.find_by(id: 0)).to be_nil
      end
    end
  end

  describe '#up' do
    let(:distance) { 3 }

    it 'moves the robot upwards' do
      expect { repo.up(robot, distance) }.to change(robot, :y).by(distance)
    end
  end

  describe '#down' do
    let(:y) { 3 }
    let(:distance) { 3 }

    it 'moves the robot downwards' do
      expect { repo.down(robot, distance) }.to change(robot, :y).by(-distance)
    end
  end

  describe '#right' do
    let(:distance) { 3 }

    it 'moves the robot rightwards' do
      expect { repo.right(robot, distance) }.to change(robot, :x).by(distance)
    end
  end

  describe '#left' do
    let(:y) { 3 }
    let(:distance) { 3 }

    it 'moves the robot leftwards' do
      expect { repo.left(robot, distance) }.to change(robot, :x).by(-distance)
    end
  end

  describe '#save' do
    it 'persists the robot in the database' do
      expect { repo.save(robot) }.not_to raise_error
    end
  end

  describe '#grab_crate' do
    let(:crate) { create :crate, x: robot.x, y: robot.y, warehouse: warehouse }

    it 'assigns a crate to the robot' do
      expect { repo.grab_crate(robot) }.to change(robot, :crate).from(nil).to(crate)
    end
  end

  describe '#drop_crate' do
    let(:crate) { create :crate, x: warehouse.width, y: warehouse.length, warehouse: warehouse }
    let(:robot) { create :robot, x: x, y: y, crate: crate, warehouse: warehouse }

    it "moves the crate in the robot's location" do
      expect { repo.drop_crate(robot) }.to change(crate, :location).to(robot.location)
    end

    it 'drops the crate' do
      expect { repo.drop_crate(robot) }.to change(robot, :crate).from(crate).to(nil)
    end

    it 'deattaches from the robot' do
      expect { repo.drop_crate(robot) }.to change(crate, :robot).from(robot).to(nil)
    end
  end

  describe '#holding_crate?' do
    context 'when holding a crate' do
      let(:robot) { create :robot, :holding_crate }

      it 'returns true' do
        expect(repo).to be_holding_crate(robot)
      end
    end

    context 'when not holding a crate' do
      let(:robot) { create :robot }

      it 'returns false' do
        expect(repo).not_to be_holding_crate(robot)
      end
    end
  end
end
