# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operational::GrabbingService do
  subject(:drop_service) { described_class.new(robots_repo: repo) }

  let(:repo) { instance_double Repositories::Robots::Base, grab_crate: nil, holding_crate?: crate }
  let(:robot) { build(:robot) }
  let(:crate) { false }

  describe '#call' do
    before { drop_service.call(robot: robot) }

    it 'calls the robots repository' do
      expect(repo).to have_received(:grab_crate).with(robot)
    end

    context 'without a robot' do
      let(:robot) { nil }

      it 'does not call the robots repository' do
        expect(repo).not_to have_received(:grab_crate).with(robot)
      end
    end

    context 'with a robot already holding a crate' do
      let(:crate) { true }

      it 'does not call the robots repository' do
        expect(repo).not_to have_received(:grab_crate).with(robot)
      end
    end
  end
end
