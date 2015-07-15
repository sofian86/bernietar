require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }
  let(:twitter) { create(:identity, :twitter, user: user) }

  subject { user }

  it { should be_valid }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it "should return the current Twitter avatar URI" do
    expect(twitter.user.current_provider_avatar('twitter')).to be_a_kind_of(Addressable::URI)
  end

  it "should update the user's Twitter avatar" do
    expect(twitter.user.update_provider_avatar('twitter')).to be_an_instance_of(Twitter::User)
  end

  it "should establish a Twitter client" do
    expect(twitter.user.send(:establish_twitter_client)).to be_an_instance_of(Twitter::REST::Client)
  end

  context "doesn't have token or secret saved" do
    before do
      twitter_identity = create(:identity, user:user)
      twitter_identity.token   = ""
      twitter_identity.secret  = ""
      twitter_identity.save
    end
    it "should not establish a Twitter client" do
      expect(user.send(:establish_twitter_client)).to eq(nil)
    end
  end
end
