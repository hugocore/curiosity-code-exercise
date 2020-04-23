# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::Robots::ActiveRecordAdaptor do
  subject(:repo) { described_class.new }

  let(:robot) { create :robot, x: x, y: y }
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
end
