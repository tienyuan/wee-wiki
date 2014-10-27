require 'rails_helper'

describe Page do 

  describe "class methods" do
    before do
      @page = create(:page)
    end

    describe "ActiveModel validations" do
      it { expect(@page).to validate_presence_of(:title).with_message( /can't be blank/ ) }
      it { expect(@page).to validate_presence_of(:body).with_message( /can't be blank/ ) }
    end

    describe "ActiveRecord associations" do
      it { expect(@page).to belong_to(:wiki) }
    end
  end
end
