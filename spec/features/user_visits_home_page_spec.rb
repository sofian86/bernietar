require 'rails_helper'

feature "User visits home" do

  let(:user) { FactoryGirl.create(:user) }
  before do
    visit root_path
  end

  subject { page }

  describe "page" do

    it { should have_css('.hero') }

  end
end