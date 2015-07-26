FactoryGirl.define do
  factory :identity do
    provider      'network' # make sure to define a trait from below
    uid           { Faker::Number.number(11) }
    token         "lk;j23roj;pasojf"
    secret        "ljkpaoiwefjojoij8oiuhjsdf"
    association   :user

    trait :twitter do
      after(:create) do |identity|
        identity.provider = 'twitter'
        identity.save
      end
    end

    trait :facebook do
      after(:create) do |identity|
        identity.provider = 'facebook'
        identity.token = 'CAAMBWjkFywEBAPZCTJcPiqXSbzX1flMrBfPjcdYp8Lk1whyOYORpdElBegXMUXXeUoNqcrUufqLZAEKC7700xkZBvFZA0AjueyZCRNZAv6BwTb9UUJ2he54S143XP9HDDLsX7mMQLs8w5DRLXsQpQFfrcAAYy4oiJIrluZCOtdL8xErrJk04qEphmTrvsD40YFgx8wleOXTFEZCHCRTZBZCUuRZATarGg0zV00ZD'
        identity.save
      end
    end
  end
end
