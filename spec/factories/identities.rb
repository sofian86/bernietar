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
        identity.token = 'CAAMBWjkFywEBAEXOZC4MfSbk0VYiXEVjWbaraziPPHQ0VxsPG1U1ZCeNiPbHYxGwfkdrZCwGZB2Qie7evDvagZBtLdviZBHE3vQRkKG4331eAKyzpu9yaYZAZBaS2AwuyZCJprl2aGZB0L2ZBcoeuJQJE3sncPk7dzWAqHdX2TwsqZAO3Tc5FoaFsG3gHmqSfRUtZBd36BZBoDZAlQxF602QrQ3bGCZA'
        # Uncomment for a VCR pass
        # identity.bernietar_location = '122035284805695'
        identity.save
      end
    end
  end
end
