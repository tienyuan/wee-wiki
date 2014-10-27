require 'rails_helper'

describe Collaboration do 

  describe "class methods" do
    before do
      @collaboration = create(:collaboration)
    end

    describe "ActiveRecord associations" do
      it { expect(@collaboration).to belong_to(:wiki) }
      it { expect(@collaboration).to belong_to(:user) }
    end
  end
end
