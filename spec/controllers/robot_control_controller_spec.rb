# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RobotControlController, type: :controller do
  let(:warehouse) { create :warehouse, width: 10, length: 10 }
  let(:robot) { create :robot, x: x, y: y, warehouse: warehouse }
  let(:commands) { 'N' }
  let(:robot_id) { robot.id }
  let(:x) { 1 }
  let(:y) { 1 }

  before do
    post :control, params: { id: robot_id, commands: commands }
  end

  describe 'POST control' do
    it 'responds with a 204' do
      expect(response).to have_http_status(:no_content)
    end

    it 'controls the robot movement' do
      expect(robot.reload.location).to eq([1, 2])
    end

    context 'with an invalid move' do
      let(:commands) { 'A' }

      it 'responds with a 204' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not move the robot' do
        expect(robot.reload.location).to eq([1, 1])
      end
    end

    context 'with a list of commands' do
      let(:commands) { ' N E N E N E N E' }

      it 'responds with a 204' do
        expect(response).to have_http_status(:no_content)
      end

      it 'controls the robot movement' do
        expect(robot.reload.location).to eq([5, 5])
      end
    end

    context 'with a list containing invalid commands' do
      let(:commands) { 'N X N' }

      it 'responds with a 204' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'stops the sequence on the first invalid command' do
        expect(robot.reload.location).to eq([2, 1])
      end
    end

    context 'with a list of commands without spaces' do
      let(:commands) { 'NENENENE ' }

      it 'responds with a 204' do
        expect(response).to have_http_status(:no_content)
      end

      it 'controls the robot movement' do
        expect(robot.reload.location).to eq([5, 5])
      end
    end

    context 'without commands' do
      let(:commands) { nil }

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
