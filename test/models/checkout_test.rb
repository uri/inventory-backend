require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase

  test 'initialize checkouts checked_out_at timestamp' do
    checkout = FactoryGirl.create(:checkout)
    assert_not_nil checkout.checked_out_at
  end
end