# frozen_string_literal: true

FactoryBot.define do
  factory :warehouse do
    width { rand(1..10) }
    length { rand(1..10) }

    trait :with_robot do
      transient do
        robots { create_list :robot, 1 }
      end
    end

    trait :with_crate do
      transient do
        crates { create_list :crates, 1 }
      end
    end
  end
end
