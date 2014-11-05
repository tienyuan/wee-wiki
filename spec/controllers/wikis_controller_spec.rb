require 'rails_helper'

describe WikisController, :type => :controller do

  include Devise::TestHelpers

  before do
    @user = create(:user)
    sign_in @user
  end

  describe "#index" do
    render_views
    
    it "shows public wikis, private owned wikis and private collaboration wikis" do
      public_wiki = create(:wiki)
      owned_wiki = create(:wiki, private: true, owner: @user)
      collaboration_wiki = create(:wiki, private: true)
      collaboration = create(:collaboration, wiki: collaboration_wiki, user: @user)
      other_private_wiki = create(:wiki, private: true)

      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(Wiki.count).to eq(4)
      expect(response.body).to include public_wiki.title 
      expect(response.body).to include owned_wiki.title 
      expect(response.body).to include collaboration_wiki.title 
      expect(response.body).not_to include other_private_wiki.title 
    end
  end

  describe "#show" do
    render_views

    it "shows with a valid wiki" do
      wiki = create(:wiki)
      get :show, {id: wiki.id}

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include wiki.title
      expect(response.body).to include wiki.description
    end
  end

  describe "#new" do
    it "shows a new wiki form" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)      
    end
  end

  describe "#create" do
    it "creates with valid title and description" do
      params = {wiki: {title: 'wiki title', description: 'wiki description'}}
      post :create, params

      expect(response).to be_redirect
      expect(Wiki.last.title).to eq('wiki title')
    end

    it "fails with a blank title" do
      params = {wiki: {title: '', description: 'wiki description'}}
      post :create, params

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Wiki failed. Please try again."
    end

    it "fails with a blank description" do
      params = {wiki: {title: 'wiki title', description: ''}}
      post :create, params

     expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Wiki failed. Please try again."
    end
  end

  describe "#edit" do
    it "edits a page" do
      @wiki = create(:wiki, owner_id: @user.id)
      get :edit, {id: @wiki.id}

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    before do
      @wiki = create(:wiki, title: 'old title', owner: @user)
    end

    it "updates with valid info" do
      expect(@wiki.title).to eq('old title')
      expect(@wiki.slug).to eq('old-title')
      patch :update, id: @wiki.id, wiki:{title: 'new title'}
      @wiki.reload

      expect(response).to be_redirect
      expect(@wiki.title).to eq('new title')
      expect(@wiki.slug).to eq('new-title')
    end

    it "fails without a title " do
      invalid_title = ""
      patch :update, id: @wiki.id, wiki:{title: invalid_title}

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Wiki edit failed. Please try again."
    end

    it "fails without a description" do
      invalid_description = ""
      patch :update, id: @wiki.id, wiki:{description: invalid_description}

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq "Wiki edit failed. Please try again."
    end
  end

end
