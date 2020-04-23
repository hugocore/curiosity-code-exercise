# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::Crates::ActiveRecordAdaptor do
  subject(:repo) { described_class.new }

  let(:crate) { create :crate, x: x, y: y }
  let(:x) { 1 }
  let(:y) { 1 }

  describe '#find_by_id' do
    it 'finds the crate by ID' do
      expect(repo.find_by(id: crate.id)).to eq(crate)
    end

    context 'with an invalid ID' do
      it 'finds the crate by ID' do
        expect(repo.find_by(id: 0)).to be_nil
      end
    end
  end
end
