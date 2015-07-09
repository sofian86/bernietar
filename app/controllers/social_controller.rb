class SocialController < ApplicationController
  before_action :authenticate_user!

  def explanation
    @network = params[:network]

    case @network
      when "twitter"
        @current_avatar = @twitter_client.user.profile_image_uri(size = :original)
    end
  end
end
