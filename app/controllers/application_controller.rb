class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Try and setup the twitter client
  before_action :set_twitter_client

  private

  def set_twitter_client
    if user_signed_in? && @twitter_client.nil?
      @twitter_client = current_user.establish_twitter_client
    end
  end
end
