require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase

  should 'initialize checkouts checked_out_at timestamp' do
    checkout = FactoryGirl.build(:checkout)
    checkout.stubs(:item_was_properly_reserved).returns(nil)
    assert_difference 'Checkout.count', 1 do checkout.save end
    assert_not_nil checkout.checked_out_at
  end

  context 'given an item and a member' do 
    setup do 
      @item = FactoryGirl.create(:item)
      @member = FactoryGirl.create(:user)
    end

    should 'checkout an item if properly reserved' do
      reservation = FactoryGirl.create(
        :reservation,
        item: @item,
        beginning: 5.minutes.ago,
        ending: 2.hours.from_now,
        user: @member)
      checkout = FactoryGirl.build(:checkout, reservation: reservation)
      checkout.member = @member
      assert checkout.save
    end

    should 'not allow to checkout if no reservation was made' do
      checkout = FactoryGirl.build(:checkout, reservation: nil)
      checkout.member = @member
      assert !checkout.save
      assert checkout.errors.any?
    end

    should 'not allow to check out an item too early' do
      reservation = FactoryGirl.create(
        :reservation,
        item: @item,
        beginning: 1.hour.from_now,
        ending: 2.hours.from_now,
        user: @member)
      checkout = FactoryGirl.build(:checkout, reservation: reservation)
      checkout.member = @member
      assert !checkout.save
      assert checkout.errors.any?
    end
  end
end