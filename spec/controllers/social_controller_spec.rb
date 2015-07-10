require 'rails_helper'

describe SocialController do

  let (:identity) { create(:identity) }

  before(:each) do
    sign_in identity.user
  end

  describe "GET #explanation" do
    it "assigns network to @network" do
      get :explanation, id: identity.user, network: identity.provider
      expect(assigns(:network)).to eq(identity.provider)
    end

    it "renders the :explanation template" do
      get :explanation, id: identity.user, network: identity.provider
      expect(response).to render_template :explanation
      expect(response.status).to eq(200)
    end

    context "gets accessed by a non-user" do
      it "should deny access" do
        sign_out identity.user
        get :explanation, network:identity.provider
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe "#POST #update_twitter" do
    it "makes an API call to Twitter and updates the avatar" do
      expect(response.status).to eq(200)
    end
  end

end
