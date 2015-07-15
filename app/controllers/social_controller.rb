class SocialController < ApplicationController
  before_action :authenticate_user!

  # Let the user know what actions we're about to perform
  def explanation
    @network = params[:network]
    @current_avatar = current_user.current_provider_avatar(@network)
  end

  # Let them know we've updated their avatar successfully. Maybe they want to do another?
  def all_done
    @network = params[:network]
  end
end
