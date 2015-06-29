class SocialController < ApplicationController

  def explanation
    @network = params[:network]
  end

end
