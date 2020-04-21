# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  subject(:warehouse) { create :warehouse, width: 10, length: 10 }

  it { is_expected.to have_attributes(width: 10) }
  it { is_expected.to have_attributes(length: 10) }

  context 'with robots' do
    subject(:warehouse) { create :warehouse, :with_robots, width: 10, length: 10 }

    it 'holds robots' do
      expect(warehouse.robots.count > 0).to be_truthy
    end
  end

  context 'with crates' do
    subject(:warehouse) { create :warehouse, :with_crates, width: 10, length: 10 }

    it 'holds robots' do
      expect(warehouse.crates.count > 0).to be_truthy
    end
  end
end
