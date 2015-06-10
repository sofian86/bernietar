FactoryGirl.define do
  factory :identity do
    provider    'twitter'
    uid         Random.rand.to_s[2..11]
    association :user
  end
end