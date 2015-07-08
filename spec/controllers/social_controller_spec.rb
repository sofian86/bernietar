require 'rails_helper'

describe SocialController do

  let (:identity) { create(:identity) }

  before(:each) do
    OmniAuth.config.mock_auth[:twitter] = nil # reset
    sign_in identity.user
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
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
        sign_out user
        get :explanation, network:identity.provider
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe "#POST #update_twitter" do

  end

end
