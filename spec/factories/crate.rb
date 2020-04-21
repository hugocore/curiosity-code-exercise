# frozen_string_literal: true

FactoryBot.define do
  factory :crate do
    x { rand(1..10) }
    y { rand(1..10) }
    warehouse

    trait :grabbed do
      after(:create) do |crate|
        create :robot, x: crate.x, y: crate.y, warehouse: crate.warehouse, crate: crate
      end
    end
  end
end
