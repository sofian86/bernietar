class SocialController < ApplicationController
  before_action :authenticate_user!

  def explanation
    @network = params[:network]

    case @network
      when "twitter"
        byebug
        puts @twitter_client.profile
        @current_avatar = @twitter_client.user.profile_image_uri(size = :original)
    end


  end

end
