require 'rails_helper'

describe ChargesController, :type => :controller do

  include Devise::TestHelpers

  before do
    @wiki = create(:wiki)
    @user = create(:user)
    sign_in @user
  end

  describe "#new" do
    render_views

    it "shows a new charge form" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(response.body).to include('Premium User Upgrade')
    end
  end

  describe "#create" do
    xit "creates with valid email, and credit card info" do
      params = {}
      post :create, params

      expect(response).to be_redirect
      expect(flash[:notice]).to eq "Thanks for upgrading, #{@user.email}! You can now create private wikis."
      expect(@user.premium).to eq true
    end
  end
end
