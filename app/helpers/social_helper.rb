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

end
