require 'rails_helper'

describe CollaborationPolicy do
  subject { described_class }

  before do
    @user = create(:user)
    @owner = create(:user)
    @collaborator = create(:user)
    private_wiki = create(:wiki, private: true, owner_id: @owner.id)
    @collaboration = create(:collaboration, wiki_id: private_wiki.id, user_id: @collaborator.id)
  end

  permissions :create? do

    it "denies access if wiki is private" do
      expect(subject).not_to permit(@user, @collaboration)
    end

    it "denies access if wiki is private and user is collaborator" do
      expect(subject).not_to permit(@collaborator, @collaboration)
    end

    it "grants access if wiki is private and owned by user" do
      expect(subject).to permit(@owner, @collaboration)
    end

  end
end