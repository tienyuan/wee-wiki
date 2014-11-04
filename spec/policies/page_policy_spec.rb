require 'rails_helper'

describe PagePolicy do
  subject { described_class }

  before do
    @user = create(:user)
    @owner = create(:user)
    @collaborator = create(:user)
    public_wiki = create(:wiki)
    private_wiki = create(:wiki, private: true, owner_id: @owner.id)
    collaboration = create(:collaboration, wiki_id: private_wiki.id, user_id: @collaborator.id)
    @public_page = create(:page, wiki_id: public_wiki.id)
    @private_page = create(:page, wiki_id: private_wiki.id)
  end

  permissions :show? do
    it "denies access if wiki is private" do
      expect(subject).not_to permit(@user, @private_page)
    end

    it "grants access if wiki is private and user is collaborator" do
      expect(subject).to permit(@collaborator, @private_page)
    end

    it "grants access if wiki is private and owned by user" do
      expect(subject).to permit(@owner, @private_page)
    end

    it "grants access if wiki is public" do
      expect(subject).to permit(@user, @public_page)
    end
  end

  permissions :create? do
    it "denies access if wiki is private" do
      expect(subject).not_to permit(@user, @private_page)
    end

    it "grants access if wiki is private and user is collaborator" do
      expect(subject).to permit(@collaborator, @private_page)
    end

    it "grants access if wiki is private and owned by user" do
      expect(subject).to permit(@owner, @private_page)
    end

    it "grants access if wiki is public" do
      expect(subject).to permit(@user, @public_page)
    end
  end

  permissions :update? do
    it "denies access if wiki is private" do
      expect(subject).not_to permit(@user, @private_page)
    end

    it "grants access if wiki is private and user is collaborator" do
      expect(subject).to permit(@collaborator, @private_page)
    end

    it "grants access if wiki is private and owned by user" do
      expect(subject).to permit(@owner, @private_page)
    end

    it "grants access if wiki is public" do
      expect(subject).to permit(@user, @public_page)
    end
  end
end