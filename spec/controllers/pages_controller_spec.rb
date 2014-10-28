require 'rails_helper'

describe Wikis::PagesController do

  include Devise::TestHelpers

  before do
    @wiki = create(:wiki)
    @page = create(:page, wiki: @wiki)
    @user = create(:user)
    sign_in @user
  end

  describe "#show" do
    render_views

    it "shows with a valid wiki and page" do
      get :show, {wiki_id: @wiki.id, id: @page.id}

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include @page.title
      expect(response.body).to include @page.body
    end
  end

  describe "#new" do
    it "shows a new page without saving" do
      get :new, {wiki_id: @wiki.id}

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)      
    end
  end

  describe "#create" do
    it "creates with valid title and description" do
      params = {wiki_id: @wiki, page: {title: 'page title', body: 'page body'}}
      post :create, params

      expect(response).to be_redirect
    end

    it "fails with a blank title" do
      params = {wiki_id: @wiki, page: {title: '', body: 'page body'}}
      post :create, params

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Page failed. Please try again."

    end

    it "fails with a blank description" do
      params = {wiki_id: @wiki, page: {title: 'page title', body: ''}}
      post :create, params

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Page failed. Please try again."
    end
  end

  describe "#edit" do
    it "edits a page" do
      get :edit, {wiki_id: @wiki.id, id: @page.id}

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    it "updates with valid info" do
      patch :update, wiki_id: @wiki.id, id: @page.id, page:{title: 'new title'}
      @page.reload

      expect( response ).to redirect_to wiki_page_path
    end

    it "fails without a title" do
      invalid_title = ""
      patch :update, wiki_id: @wiki.id, id: @page.id, page:{description: invalid_title}

      expect( response ).to redirect_to wiki_page_path
      expect(flash[:error]).to eq "There was an error updating the page."
    end

    it "fails without a description" do
      invalid_body = ""
      patch :update, wiki_id: @wiki.id, id: @page.id, page:{description: invalid_body}

      expect( response ).to redirect_to wiki_page_path
      expect(flash[:error]).to eq "There was an error updating the page."
    end
  end
end
