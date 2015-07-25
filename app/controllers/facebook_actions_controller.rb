class FacebookActionsController < ApplicationController
  before_action :authenticate_user!

  def explanation
    #TODO - Make use of the user's current facebook avatar
  end

  # Uploads the bernietar to facebook in its own album. Doesn't set the profile image because there is no API call
  # for that.
  def upload_facebook_bernietar
    if current_user.facebook_graph.put_picture("#{::Rails.root}/app/assets/images/bernietar.png")
      flash[:success] = "Great. We've uploaded your Bernitar. On to step 2."
      params[:step] = 2
      redirect_to facebook_explanation_path
    else
      redirect_to root_path
      flash[:error] = "Oops! Something went wrong."
    end
  end
end
