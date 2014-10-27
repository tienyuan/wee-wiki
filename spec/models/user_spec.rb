require 'rails_helper'

describe User do 

  describe "class methods" do
    before do
      @user = create(:user)
    end

    describe "ActiveModel validations" do
      it { expect(@user).to validate_presence_of(:name).with_message( /can't be blank/ ) }
      it { expect(@user).to validate_presence_of(:username).with_message( /can't be blank/ ) }
      it { expect(@user).to validate_uniqueness_of(:username) }
    end

    describe "ActiveRecord associations" do
      it { expect(@user).to have_many(:owned_wikis) }
    end
  end
end
