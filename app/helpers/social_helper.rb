module SocialHelper

  # You may find the need to have a corrected :provider parameter to
  # user_omniauth_authorize_path. E.g. "Linkedin" to "linked_in"
  def provider_corrector(provider)
    if provider.downcase == "linkedin"
      "linked_in".to_sym
    else
      provider.downcase.to_sym
    end
  end

  # Provide copy for each of the social buckets on the homepage
  def social_bucket_copy(provider)
    case provider
      when 'facebook'
        "Bernie's largest social reach is on Facebook. Help him further that effort by updating your Facebook avatar and cover photo."
      when 'twitter'
        "Twitter's inherently public nature makes it a great way to get the word out. Help the Twitter community <a href='https://twitter.com/search?q=%23FeelTheBern&src=tyah' target=''_blank'>#FeelTheBern</a> by updating your avatar and header photo here.".html_safe
      when "linkedin"
        "People use LinkedIn?"
    end
  end

end
