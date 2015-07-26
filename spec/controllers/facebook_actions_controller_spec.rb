require 'rails_helper'

RSpec.describe FacebookActionsController, type: :controller do

    let (:facebook) { create(:identity, :facebook) }

    before { sign_in facebook.user }

    describe "POST #upload_facebook_bernietar" do
      it "should post to user's facebook account" do
        VCR.use_cassette 'facebook/upload_facebook_bernietar' do
          post :upload_facebook_bernietar
          expect(response).to redirect_to facebook_explanation_path 2
        end
      end

      context "gets accessed by a non-user" do
        it "should deny access" do
          sign_out facebook.user
          VCR.use_cassette 'facebook/upload_facebook_bernietar' do
            post :upload_facebook_bernietar
            expect(response).to redirect_to new_user_session_path
          end
        end
      end
    end

    describe "GET #explanation" do
      # it "assigns @current_avatar" do
      #   get :explanation
      #   expect(assigns(:current_avatar)).to be_a(Addressable::URI)
      # end

      it "renders the :explanation template" do
        get :explanation, step: 1
        expect(response).to render_template :explanation
        expect(response.status).to eq(200)
      end

      context "gets accessed by a non-user" do
        it "should deny access" do
          sign_out facebook.user
          get :explanation, step: 1
          expect(response).to redirect_to user_session_path
        end
      end
    end
end
