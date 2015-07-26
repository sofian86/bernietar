require 'rails_helper'

RSpec.describe TwitterActionsController, type: :controller do

  let (:twitter)  { create(:identity, :twitter) }

  before { sign_in twitter.user }

  describe "POST #update_twitter" do
    it "makes an API call to Twitter and updates the avatar" do
      sign_in twitter.user
      post :update_twitter, id: twitter.user
      expect(response).to redirect_to social_done_path('twitter')
    end

    context "gets accessed by a non-user" do
      it "should deny access" do
        sign_out twitter.user
        post :update_twitter, id:nil
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #explanation" do
    it "assigns @current_avatar" do
      get :explanation
      expect(assigns(:current_avatar)).to be_a(Addressable::URI)
    end

    it "renders the :explanation template" do
      get :explanation
      expect(response).to render_template :explanation
      expect(response.status).to eq(200)
    end

    context "gets accessed by a non-user" do
      it "should deny access" do
        sign_out twitter.user
        get :explanation
        expect(response).to redirect_to user_session_path
      end
    end
  end
end
