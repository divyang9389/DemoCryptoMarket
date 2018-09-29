require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    before(:each) do
      @user = FactoryBot.create(:user)
    end

    it "returns http success" do
      current_user = @user
      get :index
      expect(response.content_type).to eq "text/html"
    end
  end

end
