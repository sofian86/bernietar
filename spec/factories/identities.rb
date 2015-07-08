FactoryGirl.define do
  factory :identity do
    provider      'twitter'
    uid           Random.rand.to_s[2..11]
    token         "lk;j23roj;pasojf"
    secret        "ljkpaoiwefjojoij8oiuhjsdf"
    association   :user
  end
end