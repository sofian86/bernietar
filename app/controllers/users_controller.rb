class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]
  before_action :authenticate_user!, only: [:update_twitter, :upload_facebook_bernietar]

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # If we don't have a confirmed email...
  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        # @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to explanation_path(:twitter)
      else
        @show_errors = true
      end
    end
  end


  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end


  def update_twitter
    if current_user.update_twitter_avatar
      redirect_to social_done_path 'twitter'
    else
      redirect_to root_path
      flash[:error] = "You can't do that. Please try logging in first."
    end
  end

  # Uploads the bernietar to facebook in its own album. Doesn't set the profile image because there is no API call
  # for that.
  def upload_facebook_bernietar
    @upload = current_user.upload_facebook_avatar
    if @upload
      redirect_to root_path
    else
      redirect_to root_path
      flash[:error] = "Oops! Something went wrong."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessible = [ :name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

end
