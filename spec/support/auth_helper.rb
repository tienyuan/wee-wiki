module AuthHelpers

  def setAuth
    Warden.test_mode!
  end

  def clearAuth
    Warden.test_reset!
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :feature
end