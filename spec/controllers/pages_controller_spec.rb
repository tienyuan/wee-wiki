require 'rails_helper'

RSpec.describe Wikis::PagesController, :type => :controller do

  include Devise::TestHelpers

  before do
    @user = create(:user)
    sign_in @user
  end

  describe "#show" do
    before do
      @wiki = create(:wiki)
      @page = create(:page, wiki: @wiki)
    end

    it "returns http success" do
      get :show, {wiki_id: @wiki.id, id: @page}
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    before do
      @wiki = create(:wiki)
    end

    it "returns http success" do
      get :new, {wiki_id: @wiki}
      expect(response).to have_http_status(:success)
    end
  end

  describe "#edit" do
    before do
      @wiki = create(:wiki)
      @page = create(:page, wiki: @wiki)
    end

    it "returns http success" do
      get :edit, {wiki_id: @wiki.id, id: @page}
      expect(response).to have_http_status(:success)
    end
  end

end
