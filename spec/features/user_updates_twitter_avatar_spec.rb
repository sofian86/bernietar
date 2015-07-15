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
      it { should have_field "user_email"  }
      it { should have_css "input#continue"  }
      it { should have_link "No thanks, I just want to update this one time" }

      describe "submits email" do
        before do
          fill_in "user[email]", with: "joe@example.com"
          click_button "Continue"
        end

        it { should have_content "Awesome" }
        it { should have_content "here's what's going to happen to your twitter profile" }
      end

    end
  end

end