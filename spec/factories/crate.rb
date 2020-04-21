# frozen_string_literal: true

FactoryBot.define do
  factory :crate do
    x { rand(1..10) }
    y { rand(1..10) }

    trait :picked do
      robot
    end
  end
end
