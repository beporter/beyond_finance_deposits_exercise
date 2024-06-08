# frozen_string_literal: true

FactoryBot.define do
  factory :tradeline do
    name { 'Some Credit Card' }
    amount_cents { 3223_54 }

    factory :tradeline_with_deposits do
      transient do
        deposits_cents { [] }
      end

      deposits do
        deposits_cents.map do |cents|
          association(:deposit, tradeline: instance, amount_cents: cents)
        end
      end
      after(:create) do |f, context|
        f.reload
      end
    end
  end
end
