module PagesHelper

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
        "Bernie's largest social reach is on Facebook. Help him further that effort by updating your Facebook profile photo and starting a conversation with friends and family."
      when 'twitter'
        "Twitter's inherently public nature makes it a great way to get the word out. Help the Twitter community <a href='https://twitter.com/search?q=%23FeelTheBern&src=tyah' target=''_blank'>#FeelTheBern</a> by updating your Twitter profile photo.".html_safe
      when "linkedin"
        "People use LinkedIn?"
    end
  end

  # Use the start button unless the user is logged in and has the current bernietar avatar in place
  # TODO - This also needs to check the current avatar and match against the filename...possibly.
  def start_or_update_button(provider)
    explanation_path = determine_explanation_path provider
    if user_signed_in? && !current_user.identities.where(provider: provider).blank?
      if current_user.bernietar_set?(provider)
        link_to 'Complete', explanation_path, class:'btn btn-margin btn-danger btn-wide', disabled: 'disabled', id:"#{provider}-update"
      else
        link_to 'Update', explanation_path, class:'btn btn-margin btn-danger btn-wide', id:"#{provider}-update"
      end
    else
      link_to 'Start', user_omniauth_authorize_path(provider_corrector(provider)), class:'btn btn-margin btn-danger btn-wide', id:"#{provider}-start"
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

  private

  def determine_explanation_path(provider)
    case provider
    when 'twitter'
      twitter_explanation_path
    when 'facebook'
      facebook_explanation_path 1
    end
  end

end
