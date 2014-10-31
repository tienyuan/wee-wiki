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
      expect(response.body).to include('script class=\'stripe-button\' src="https://checkout.stripe.com/checkout.js"')
      expect(response.body).to include('data-key')
      expect(response.body).to include('data-amount="1000"')
      expect(response.body).to include('data-description="Premium User Upgrade"')
      expect(response.body).to include('data-email="' + @user.email)
    end
  end
end
