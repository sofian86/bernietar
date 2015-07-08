class SocialController < ApplicationController
  before_action :authenticate_user!

  def explanation
    @network = params[:network]

    case @network
      when "twitter"
        user_token = current_user.identities.where(provider:@network).pluck(:token).join(" ")
        user_secret = current_user.identities.where(provider:@network).pluck(:secret).join(" ")

        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = Rails.application.secrets.twitter_consumer_key
          config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
          config.access_token        = user_token
          config.access_token_secret = user_secret
        end

        # client.update("blarg")
    end


  end

end
