class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Try and setup the twitter client
  before_action :set_twitter_client

  private

  # Try and set the twitter client if they're logged in
  def set_twitter_client
    current_user.establish_twitter_client if user_signed_in?
  end
end
