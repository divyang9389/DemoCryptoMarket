require 'rails_helper'

RSpec.describe Identity, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "12345678910",
      info: {
        email: "test@example.com",
        first_name: "Jane",
        last_name: "Doe"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now
      }
    })
  end

  subject { described_class.new(provider: "Google", uid: "sampleUid", user_id: @user.id) }

  # Test case for validation
  describe "Validation" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a provider" do
      subject.provider = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a uid" do
      subject.uid = nil
      expect(subject).to_not be_valid
    end
  end

  # Association test case
  describe "Association" do
    it { should belong_to(:user) }
  end

  # class methods test case
  describe "Class metods" do
    it "is find identity from auth provider & uid" do
      auth = stub_omniauth
      identity  = FactoryBot.create(:identity, provider: "google", uid: "12345678910", user_id: @user.id)
      identity1 = FactoryBot.create(:identity, provider: "google", uid: "12345678911", user_id: @user.id)
      identity2 = FactoryBot.create(:identity, provider: "google", uid: "12345678912", user_id: @user.id)

      expect(Identity.find_from_omniauth(auth)).to eq(identity)
    end

    it "is create new Identity base on base of auth detail for user" do
      auth = stub_omniauth
      expect(Identity.create_from_omniauth(auth, @user)).to  be_valid
      expect(Identity.create_from_omniauth(auth, @user).errors).to  be_empty
      expect(Identity.create_from_omniauth(auth, @user).provider).to  eq("google")
      expect(Identity.create_from_omniauth(auth, @user).uid).to  eq("12345678910")
    end
  end
end
