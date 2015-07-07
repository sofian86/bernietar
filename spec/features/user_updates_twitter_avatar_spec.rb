require 'rails_helper'

feature "Twitter authentication" do

  subject {page}

  describe "home page" do
    before { visit root_path }

    it { should have_content "Bernietar" }
    it { should have_link('twitter-start') }

    describe "starts Twitter process" do

      before do
        mock_auth_hash
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
        click_link('twitter-start')
      end

      it { should have_content "Can we get your email?" }
      it { should  }

    end
  end

end