class Subscription
  PRICE_CENTS = 1000.freeze

  def self.price_usd
    PRICE_CENTS/100
  end

  def self.price_cents
    PRICE_CENTS
  end

  def self.pretty_price
    "$#{sprintf('%.2f', price_usd)}"
  end
end