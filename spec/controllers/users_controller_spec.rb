require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let (:twitter) { create(:identity, :twitter) }

  describe "POST #update_twitter" do
    it "makes an API call to Twitter and updates the avatar" do
      sign_in twitter.user
      post :update_twitter, id: twitter.user
      expect(response).to redirect_to social_done_path(twitter.user, 'twitter')
    end
  end

end
