require 'rails_helper'

describe Wiki do

  describe '.viewable_wikis(user)' do
    it 'returns public wikis, private owned wikis and private collaboration wikis' do
      user = create(:user)
      public_wiki = create(:wiki)
      owned_wiki = create(:wiki, private: true, owner: user)
      collaboration_wiki = create(:wiki, private: true)
      create(:collaboration, wiki: collaboration_wiki, user: user)
      create(:wiki, private: true)

      expect(Wiki.count).to eq(4)
      wiki_list = Wiki.viewable_wikis(user)
      expect(wiki_list).to match_array([public_wiki, owned_wiki, collaboration_wiki])
    end
  end

  describe '.viewable_wikis(user) when user is nil' do
    it 'returns public wikis' do
      user = nil
      public_wiki = create(:wiki)
      create(:wiki, private: true)
      collaboration_wiki = create(:wiki, private: true)
      create(:collaboration, wiki: collaboration_wiki)
      create(:wiki, private: true)

      expect(Wiki.count).to eq(4)
      wiki_list = Wiki.viewable_wikis(user)
      expect(wiki_list).to match_array([public_wiki])
    end
  end

  describe '.viewable_wikis(user) when user is nil' do
    it 'returns public wikis' do
      a_wiki = create(:wiki, title: 'A wiki')
      b_wiki = create(:wiki, title: 'B wiki')
      c_wiki = create(:wiki, title: 'C wiki')

      expect(Wiki.sort_asc).to eq([a_wiki, b_wiki, c_wiki])
    end
  end

  describe 'ActiveModel validations' do
    before do
      @wiki = create(:wiki)
    end

    it { expect(@wiki).to validate_presence_of(:title).with_message(/can't be blank/) }
    it { expect(@wiki).to validate_uniqueness_of(:title) }
    it { expect(@wiki).to validate_presence_of(:description).with_message(/can't be blank/) }
  end

  describe 'ActiveRecord associations' do
    before do
      @wiki = create(:wiki)
    end
    
    it { expect(@wiki).to belong_to(:owner) }
    it { expect(@wiki).to have_many(:pages) }
    it { expect(@wiki).to have_many(:users) }
  end
end
