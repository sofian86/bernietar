require 'rails_helper'

feature "Twitter authentication" do

  subject {page}

  describe "home page" do
    before { visit root_path }

    it { should have_content "Bernietar" }
    it { should have_link("Start", href:'/users/auth/twitter') }

    describe "starts Twitter process" do

      before do
        OmniAuth.config.test_mode = true
        click_link("Start", href:'/users/auth/twitter')
      end

      it { should have_content "Awesome" }

    end
  end

end