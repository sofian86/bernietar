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
        identity.token = 'CAAMBWjkFywEBALy9rrfvPvfI3utSPbKb6zM8pFrmH3ZAZCmliTR0K4oiho2XMzSHOWT1T7ZAVMwjriegygZBoAabQhLLZCR1ZADmTsmxBvl6ZBrtxQAIQP0wAIyTXM5gYernkDGlhnXGxoyiTuxBjkmZBI1MekZA2Vg3cwZAlhvD4clZAJSmdcNIzM4arJMnzmxuJZBfCwSpqSXDKz20Ja9WOaup'
        identity.save
      end
    end
  end
end
