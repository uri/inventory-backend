require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase

  should 'initialize checkouts checked_out_at timestamp' do
    checkout = FactoryGirl.build(:checkout)
    checkout.member = FactoryGirl.build(:user)
    checkout.stubs(:item_was_properly_reserved).returns(nil)
    assert_difference 'Checkout.count', 1 do
      checkout.save
    end
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
      assert checkout.item.in_use
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

    should 'not allow to check the item out twice' do
      reservation = FactoryGirl.create(
        :reservation,
        item: @item,
        beginning: 1.hour.ago,
        ending: 2.hours.from_now,
        user: @member)
      checkout = FactoryGirl.build(
        :checkout,
        member: @member,
        reservation: reservation )
      assert checkout.save
      checkout_2 = FactoryGirl.build(
        :checkout,
        member: @member,
        reservation: reservation )
      assert !checkout_2.save
    end

    should 'not alow to check out if item is reserved for another member' do
      other_member = FactoryGirl.create(:user)
      other_reservation = FactoryGirl.create(
        :reservation,
        item: @item,
        beginning: 1.hour.ago,
        ending: 2.hours.from_now,
        user: other_member)
      reservation = FactoryGirl.create(
        :reservation,
        item: @item,
        beginning: 3.hour.from_now,
        ending: 4.hours.from_now,
        user: @member)
      checkout = FactoryGirl.build(
        :checkout,
        member: @member,
        reservation: reservation)
      assert !checkout.save
    end
  end
end