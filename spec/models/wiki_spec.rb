require 'rails_helper'

describe Wiki do 

  describe "class methods" do
    before do
      @wiki = create(:wiki)
    end

    describe "ActiveModel validations" do
      it { expect(@wiki).to validate_presence_of(:title).with_message( /can't be blank/ ) }
      it { expect(@wiki).to validate_uniqueness_of(:title) }
      it { expect(@wiki).to validate_presence_of(:description).with_message( /can't be blank/ ) }
    end

    describe "ActiveRecord associations" do
      it { expect(@wiki).to belong_to(:owner) }
      it { expect(@wiki).to have_many(:pages) }
    end
  end
end
