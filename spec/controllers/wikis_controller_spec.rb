require 'rails_helper'

RSpec.describe WikisController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    
    before do
      @wiki = create(:wiki)
    end

    it "returns http success" do
      get :show, {id: @wiki.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do

    before do
      @wiki = create(:wiki)
    end

    it "returns http success" do
      get :edit, {id: @wiki.id}
      expect(response).to have_http_status(:success)
    end
  end

end
