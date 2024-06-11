# frozen_string_literal: true

FactoryBot.define do
  factory :deposit do
    association :tradeline, amount_cents: 1000_00
    deposit_date { Date.yesterday.to_s } # Intentionally use a string instead of Date object.
    amount_cents { 55_43 }

    trait :future do
      deposit_date { Date.tomorrow.to_s }
    end
  end
end
