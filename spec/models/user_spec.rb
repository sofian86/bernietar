require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

  before do
    @user = User.new(
        email: 'user@example.com',
        password: 'foobarbaz',
        password_confirmation: 'foobarbaz'
    )
  end

  subject { user }

  it { should be_valid }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it "should return the user's Twitter profile" do

  end



  
end
