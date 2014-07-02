require 'test_helper'

class ReservationsTest < ActiveSupport::TestCase

  def setup
    @member = User.create(
      email: 'bob@example.com',
      password: 'secret' )
    @member_two = User.create(
      email: 'mike@example.com',
      password: 'secret' )
    
    @item = Item.create(name: 'Laser Cutter')

    @reservation = @member.reservations.new(
      beginning: 2.hours.from_now,
      ending:    5.hours.from_now,
      item_id:   @item.id )
    @reservation.save
  end
  
  test 'save valid reservations' do
    assert_difference 'Reservation.count', 1 do
      reservation = @member_two.reservations.new(
        beginning: @reservation.ending,
        ending:    @reservation.ending + 1.hour,
        item_id:   @item.id )
      reservation.save
    end
    assert_difference 'Reservation.count', 1 do
      reservation = @member_two.reservations.new(
        beginning: @reservation.beginning - 1.hour,
        ending:    @reservation.beginning,
        item_id:   @item.id )
      reservation.save
    end
  end

  test 'fail to save a reservation overlapping with an existing one on the left' do
    reservation = @member_two.reservations.new(
      beginning: @reservation.beginning - 1.hour,
      ending:    @reservation.beginning + 1.hour,
      item_id:   @item.id )
    assert_no_difference 'Reservation.count' do
      reservation.save
    end
    assert reservation.errors.any?
  end

  test 'fail to save a reservation overlapping with an existing one on the right' do
    reservation = @member_two.reservations.new(
      beginning: @reservation.ending - 1.hour,
      ending:    @reservation.ending + 1.hour,
      item_id:   @item.id )
    assert_no_difference 'Reservation.count' do
      reservation.save
    end
    assert reservation.errors.any?
  end

  test 'fail to save a reservation falling within an existing one' do
    reservation = @member_two.reservations.new(
      beginning: @reservation.beginning + 1.hour,
      ending:    @reservation.ending    - 1.hour,
      item_id:   @item.id )
    assert_no_difference 'Reservation.count' do
      reservation.save
    end
    assert reservation.errors.any?
  end

  test 'fail to save a reservation completely covering an existing one' do
    reservation = @member_two.reservations.new(
      beginning: @reservation.beginning - 1.hour,
      ending:    @reservation.ending    + 1.hour,
      item_id:   @item.id )
    assert_no_difference 'Reservation.count' do
      reservation.save
    end
    assert reservation.errors.any?
  end
end
