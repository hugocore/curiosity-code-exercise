# frozen_string_literal: true

FactoryBot.define do
  factory :robot do
    x { rand(1..10) }
    y { rand(1..10) }
    warehouse

    trait :holding_crate do
      crate
    end
  end
end
