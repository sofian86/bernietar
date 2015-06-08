require 'rails_helper'

RSpec.describe Identity, type: :model do

  let(:identity) { create(:identity) }

  subject { identity }

  it { should be_valid }
  it { should respond_to(:user_id) }
  it { should respond_to(:provider) }
  it { should respond_to(:uid) }

  it { should validate_presence_of(:uid) }

  it { expect(create(:identity)).to validate_uniqueness_of(:uid).scoped_to(:provider) }

  # Make sure that attempting to create a new identity does so
  it "should create a new identity" do
    expect{create(:identity)}.to change{Identity.count}.by(1)
  end

  # Class method: find_for_oauth
  it "shouldn't create a new identity" do
    new_identity = create(:identity)
    expect{ Identity.find_for_oauth(new_identity) }.to change{ Identity.count }.by(0)
  end

end
