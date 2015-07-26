require 'rails_helper'

describe PagesController do

  let (:identity) { create(:identity) }
  let (:twitter) { create(:identity, :twitter) }

  before(:each) do
    sign_in identity.user
  end
  
  describe "GET #all_done" do
    it "renders the :all_done template" do
      get :all_done, id: twitter.user, network: 'twitter'
      expect(response).to render_template :all_done
      expect(response.status).to eq 200
    end
  end

end
