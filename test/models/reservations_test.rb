require 'test_helper'

class ReservationsTest < ActiveSupport::TestCase

  context 'item can be reserved only once for a period of time' do
    setup do
      @member_1 = FactoryGirl.create(:user)
      @member_2 = FactoryGirl.create(:user)
      @item = FactoryGirl.create(:item)
      @reservation = FactoryGirl.create(
        :reservation,
        user: @member_1,
        beginning: 2.hours.from_now,
        ending:    5.hours.from_now,
        item:   @item )
    end
    
    should 'save valid reservations' do
      assert_difference 'Reservation.count', 1 do
        FactoryGirl.create(
          :reservation,
          user: @member_2,
          beginning: @reservation.ending,
          ending:    @reservation.ending + 1.hour,
          item:   @item )
      end
      assert_difference 'Reservation.count', 1 do
        FactoryGirl.create(
          :reservation,
          user: @member_2,
          beginning: @reservation.beginning - 1.hour,
          ending:    @reservation.beginning,
          item:   @item )
      end
    end

    should 'invalidate a reservation overlapping with ' +
           'an existing one on the left' do
      reservation = FactoryGirl.build(
        :reservation,
        user: @member_2,
        beginning: @reservation.beginning - 1.hour,
        ending:    @reservation.beginning + 1.hour,
        item:   @item )
      assert !reservation.valid?
    end

    should 'invalidate a reservation overlapping with an ' +
           'existing one on the right' do
      reservation = FactoryGirl.build(
        :reservation,
        user: @member_2,
        beginning: @reservation.ending - 1.hour,
        ending:    @reservation.ending + 1.hour,
        item:   @item )
      assert !reservation.valid?
    end

    should 'invalidate a reservation falling within an existing one' do
      reservation = FactoryGirl.build(
        :reservation,
        user: @member_2,
        beginning: @reservation.beginning + 1.hour,
        ending:    @reservation.ending - 1.hour,
        item:   @item )
      assert !reservation.valid?
    end

    should 'invalidate a reservation completely covering an existing one' do
      reservation = FactoryGirl.build(
        :reservation,
        user: @member_2,
        beginning: @reservation.beginning - 1.hour,
        ending:    @reservation.ending + 1.hour,
        item:   @item )
      assert !reservation.valid?
    end
  end


  context 'simple model validations' do
    setup do
      @member = FactoryGirl.create(:user)
      @item   = FactoryGirl.create(:item)
    end

    should 'make sure beginning is less than ending' do
      reservation = FactoryGirl.build(
        :reservation,
        beginning: 2.days.from_now,
        ending:    1.day.from_now,
        user:      @member,
        item:      @item)
      assert !reservation.valid?
    end
  end
end
