module FacebookActionsHelper

  # Applies a css class 'inactive' if you're not on that step
  def active_step?(step_number)
    'inactive' unless step_number == @step.to_i
  end

  def finalize_facebook_button
    if @step.to_i == 2
      link_to 'Go to Facebook', @uploaded_bernietar_uri, target: '_blank', class:'btn btn-success btn-margin'
    else
      link_to 'Go to Facebook', '#', class:'btn btn-success btn-margin', disabled:'disabled'
    end
  end

  def facebook_logged_in?
    true if current_user.identities.find_by_provider('facebook')
  end

end
