# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Robot, type: :model do
  subject { create :robot }

  it { is_expected.to have_attributes(x: (a_value >= 1)) }
  it { is_expected.to have_attributes(y: (a_value >= 1)) }
  it { is_expected.to have_attributes(x: (a_value <= 10)) }
  it { is_expected.to have_attributes(y: (a_value <= 10)) }
end
