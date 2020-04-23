# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RobotNavigationController, type: :controller do
  let(:warehouse) { create :warehouse, width: 10, length: 10 }
  let(:robot) { create :robot, x: x, y: y, warehouse: warehouse }
  let(:directions) { 'N' }
  let(:robot_id) { robot.id }
  let(:x) { 1 }
  let(:y) { 1 }

  before do
    post :move, params: { id: robot_id, directions: directions }
  end

  describe 'POST move' do
    it 'responds with a 204' do
      expect(response).to have_http_status(:no_content)
    end

    it 'makes the robot move' do
      expect(robot.reload.location).to eq([1, 2])
    end

    context 'with an invalid move' do
      let(:directions) { 'A' }

      it 'responds with a 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not move the robot' do
        expect(robot.reload.location).to eq([1, 1])
      end
    end

    context 'with a list of directions' do
      let(:directions) { ' N E N E N E N E' }

      it 'responds with a 204' do
        expect(response).to have_http_status(:no_content)
      end

      it 'makes the robot move' do
        expect(robot.reload.location).to eq([5, 5])
      end
    end

    context 'with a list of directions without spaces' do
      let(:directions) { 'NENENENE ' }

      it 'responds with a 204' do
        expect(response).to have_http_status(:no_content)
      end

      it 'makes the robot move' do
        expect(robot.reload.location).to eq([5, 5])
      end
    end

    context 'without directions' do
      let(:directions) { nil }

      it 'responds with a 204' do
        expect(response).to have_http_status(:no_content)
      end

      it 'does not move the robot' do
        expect(robot.reload.location).to eq([1, 1])
      end
    end

    context 'with an invalid robot' do
      let(:robot_id) { 0 }

      it 'responds with a 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
