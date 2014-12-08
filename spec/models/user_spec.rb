require 'rails_helper'

describe User do

  describe 'class methods' do
    before do
      @user = create(:user)
    end

    describe '.allowed_users(wiki)' do
      it 'returns the owner and collaborators for a wiki' do
        collaborator = create(:user)
        wiki = create(:wiki, owner: @user)
        collaboration = create(:collaboration, wiki: wiki, user: collaborator)

        expect(User.count).to eq(2)
        user_list = User.allowed_users(wiki)
        expect(user_list).to eq([@user, collaborator])
      end
    end

    describe 'ActiveModel validations' do
      it { expect(@user).to validate_presence_of(:name).with_message(/can't be blank/) }
      it { expect(@user).to validate_presence_of(:username).with_message(/can't be blank/) }
      it { expect(@user).to validate_uniqueness_of(:username) }
    end

    describe 'ActiveRecord associations' do
      it { expect(@user).to have_many(:owned_wikis) }
      it { expect(@user).to have_many(:wikis) }
    end
  end
end
