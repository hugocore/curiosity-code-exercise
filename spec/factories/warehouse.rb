# frozen_string_literal: true

FactoryBot.define do
  factory :warehouse do
    width { rand(1..10) }
    length { rand(1..10) }

    trait :with_robots do
      after(:create) do |warehouse|
        (1..3).each do |i|
          create :robot, warehouse: warehouse, x: 1, y: i
        end
      end
    end

    trait :with_crates do
      after(:create) do |warehouse|
        (1..3).each do |i|
          create :crate, warehouse: warehouse, x: 1, y: i
        end
      end
    end
  end
end
