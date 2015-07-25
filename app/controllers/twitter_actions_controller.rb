class TwitterActionsController < ApplicationController
  before_action :authenticate_user!

  def explanation
    @current_avatar = current_user.twitter_client.user.profile_image_uri(size = :original)
  end

  def update_twitter
    encoded_image = Base64.encode64(File.open("#{::Rails.root}/app/assets/images/bernietar.png").read)
    if current_user.twitter_client.update_profile_image encoded_image
      redirect_to social_done_path 'twitter'
    else
      redirect_to root_path
      flash[:error] = "You can't do that. Please try logging in first."
    end
  end
end
