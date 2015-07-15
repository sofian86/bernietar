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

  # Use the start button unless the user is logged in and has the current bernietar avatar in place
  # TODO - This also needs to check the current avatar and match against the filename...possibly.
  def start_or_update_button(provider)
    if user_signed_in? && !current_user.identities.where(provider: provider).blank?
      link_to 'Update', explanation_path(provider_corrector(provider)), class:'btn btn-lg btn-danger', id:"#{provider}-update"
    else
      link_to 'Start', user_omniauth_authorize_path(provider_corrector(provider)), class:'btn btn-lg btn-danger', id:"#{provider}-start"
    end
  end

  # Return the appropriate verb based on the social network
  def network_verb(provider)
    case provider
      when 'twitter'
        'tweet'
      when 'facebook'
        'post'
    end
  end

  def network_explanation(provider)
    case provider
      when 'twitter'
        content_tag 'p', "We'll update your current avatar to the Bernietar so you can show your support every time you #{network_verb @network}. It just takes a single click and you'll be off and running. Pretty simple, huh?", class:'explanation'
      when 'facebook'
        content_tag 'p', "We'll upload a Bernietar to Facebook before sending you over to complete the process. You'll simply need to confirm that you would like to use the Bernietar as your profile image.", class:'explanation'
    end
  end

end
