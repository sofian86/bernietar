require 'rails_helper'

describe SocialController do

  let (:user) { create(:user) }
  let (:identity) { create(:identity, user_id: user) }

  before(:each) do
    sign_in user
  end

  describe "GET #explanation" do
    it "assigns user to @network" do
      get :explanation, id: user, network: identity.provider
      expect(assigns(:network)).to eq(identity.provider)
    end

    it "renders the :explanation template" do
      get :explanation, id: user, network: 'twitter'
      expect(response).to render_template :explanation
      expect(response.status).to eq(200)
    end
  end

end
