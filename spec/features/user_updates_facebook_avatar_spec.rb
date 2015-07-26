require 'rails_helper'

feature "Facebook authentication" do

  subject {page}

  describe "home page" do
    before { visit root_path }

    it { should have_content "Bernietar" }
    it { should have_link('facebook-start') }

    describe "starts Facebook process" do

      before do
        mock_auth_hash
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
        click_link('facebook-start')
      end

      it { should have_content "Awesome" }
      it { should have_content "here's what's going to happen to your facebook profile" }
    end
  end
end
