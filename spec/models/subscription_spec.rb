require 'rails_helper'

describe Subscription do 

  describe "class methods" do

    describe ".DEFAULT" do
      it { expect(Subscription.DEFAULT).to eq(1000) }
    end
  end
end
