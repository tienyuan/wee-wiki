require 'rails_helper'

describe Wikis::CollaborationsController do

  include Devise::TestHelpers

  before do
    @wiki = create(:wiki)
    @user = create(:user)
    sign_in @user
  end

  describe '#create' do
    render_views

    it 'creates with valid title and description' do
      params = { wiki_id: @wiki, user: { email: @user.email } }
      post :create, params

      expect(response).to be_redirect
      expect(User.last.username).to eq(@user.username)
    end

    it 'fails with a blank email' do
      params = { wiki_id: @wiki, user: { email: '' } }
      post :create, params

      expect(response).to be_redirect
      expect(flash[:error]).to eq 'Collaborator failed. Please try again.'
    end

    it 'fails with a invalid email' do
      params = { wiki_id: @wiki, user: { email: 'invalid@email.com' } }
      post :create, params

      expect(flash[:error]).to eq 'Collaborator failed. Please try again.'
    end

    it 'fails with duplicate email' do
      @collaboration = create(:collaboration, wiki: @wiki, user: @user)
      params = { wiki_id: @wiki, user: { email: @user.email } }
      post :create, params

      expect(flash[:error]).to eq 'Collaborator failed. Please try again.'
    end
  end

  describe '#destroy' do
    it 'deletes with valid info' do
      @collaboration = create(:collaboration, wiki: @wiki, user: @user)
      delete :destroy, wiki_id: @wiki.id, id: @user.id

      expect(response).to be_redirect
      expect(flash[:notice]).to eq 'Collaborator removed.'
      expect(Collaboration.count).to eq(0)
    end
  end
end
