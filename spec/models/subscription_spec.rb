require 'rails_helper'

describe Subscription do

  describe 'class methods' do

    describe '.price_cents' do
      it { expect(Subscription.price_cents).to eq(1_000) }
    end

    describe '.price_usd' do
      it { expect(Subscription.price_usd).to eq(10) }
    end

    describe '.pretty_price' do
      it { expect(Subscription.pretty_price).to eq('$10.00') }
    end
  end
end
