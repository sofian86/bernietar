class FacebookActionsController < ApplicationController
  before_action :authenticate_user!

  def explanation
    #TODO - Make use of the user's current facebook avatar
    @step = params[:step]
    @uploaded_bernietar_uri = "https://www.facebook.com/photo.php?fbid=#{current_user.facebook_identity.bernietar_location}&makeprofile=1"
  end

  # Uploads the bernietar to facebook in its own album. Doesn't set the profile image because there is no API call
  # for that.
  def upload_facebook_bernietar
    # Check to see if they already have a Bernietar
    if current_user.has_facebook_bernietar?
      # They do, so send them to the cropping process
      redirect_to facebook_explanation_path 2
    else
      # No known Bernietar, so do the upload and proceed
      uploaded_bernietar = current_user.facebook_graph.put_picture("#{::Rails.root}/app/assets/images/bernietar.png")
      if current_user.save_facebook_bernietar_id uploaded_bernietar['id']
        flash[:success] = "Great. We've uploaded your Bernitar. On to step 2."
        redirect_to facebook_explanation_path 2
      else
        redirect_to root_path
        flash[:error] = "Oops! We couldn't save your Bernietar to Facebook. Please try again later."
      end
    end
  end
end
