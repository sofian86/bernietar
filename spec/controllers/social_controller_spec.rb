require 'rails_helper'

RSpec.describe SocialController, type: :controller do

  let (:user) { create(:user) }

  before(:each) do
    sign_in :user
  end

  describe "GET #explanation" do
    it "assigns user to @user" do
      get :explanation, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "renders the :explanation template" do
      get :explanation, id: user
      expect(response).to render_template :explanation
      expect(response.status).to eq(200)
    end
  end

end
