module OmniauthMacros

  # The mock_auth configuration allows you to set per-provider (or default)
  # authentication hashes to return during integration testing.
  def mock_auth_hash

    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
       provider: 'twitter',
       uid: '12345',
       info: {
           nickname:   "johnqpublic",
           name:       "John Q Public",
           location:   "Anytown, USA",
           image:      "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
           description: "a very normal guy.",
           urls: {
               Website:  nil,
               Twitter:  "https://twitter.com/johnqpublic"
           }
       },
       credentials: {
           token:  "a1b2c3d4...", # The OAuth 2.0 access token
           secret: "abcdef1234"
       },
       extra: {
           access_token: "", # An OAuth::AccessToken object
           raw_info: {
               name: "John Q Public"
           }
       }
    })

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: '12345',
      info: {
          nickname:   "johnqpublic",
          email:      "john@example.com",
          name:       "John Q Public",
          location:   "Anytown, USA",
          image:      "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
          verified:   true
      },
      credentials: {
          token:  "a1b2c3d4...", # The OAuth 2.0 access token
          expires_at: 1321747205, # when the access token expires (it always will)
          expires: true # this will always be true
      },
      extra: {
          raw_info: {
              name:   "John Q Public",
              email:  "john@example.com"
          }
      }
    })
  end
end