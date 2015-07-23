require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }
  let(:twitter) { create(:identity, :twitter, user: user) }
  let(:facebook) { create(:identity, :facebook, user: user) }

  subject { user }

  it { should be_valid }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it "should return the current Twitter avatar URI" do
    expect(twitter.user.current_provider_avatar('twitter')).to be_a_kind_of(Addressable::URI)
  end

  it "should update the user's Twitter avatar" do
    expect(twitter.user.update_twitter_avatar).to be_an_instance_of(Twitter::User)
  end

  it "should establish a Twitter client" do
    expect(twitter.user.send(:establish_twitter_client)).to be_an_instance_of(Twitter::REST::Client)
  end

  it "should establish a Facebook graph client" do
    VCR.use_cassette 'user/establish_facebook_graph' do
      expect(facebook.user.send(:establish_facebook_graph)).to be_an_instance_of(Koala::Facebook::API)
    end
  end

  it "should upload the Bernietar to Facebook" do
    VCR.use_cassette 'user/upload_facebook_avatar' do
      expect(facebook.user.upload_facebook_avatar).to be_kind_of(Hash)
    end
  end

  context "doesn't have token or secret saved" do
    before do
      twitter.token   = ""
      twitter.secret  = ""
      twitter.save
    end
    it "should not establish a Twitter client" do
      expect(twitter.user.send(:establish_twitter_client)).to eq(nil)
    end
  end
end
