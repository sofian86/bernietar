class SocialController < ApplicationController
  before_action :authenticate_user!

  def explanation
    @network = params[:network]

    case @network
      when "twitter"
        @current_avatar = current_user.current_provider_avatar('twitter')
    end
  end

  def all_done
  end
end
