require 'rails_helper'

RSpec.describe User, type: :model do
  
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

  # class methods test case
  describe "Class metods" do
    it "is find user base on auth data and set password" do
      auth = stub_omniauth
      user = FactoryBot.create(:user, email: "test@example.com", password: "password")
      expect(User.from_omniauth(auth)).to  be_valid
      expect(User.from_omniauth(auth)).to  eq(user)
    end

    it "is create user base on auth data" do
      auth = stub_omniauth
      expect(User.from_omniauth(auth)).to  be_valid
      expect(User.from_omniauth(auth).email).to eq("test@example.com")
    end

  end

end
