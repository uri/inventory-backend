class Checkout < ActiveRecord::Base
  belongs_to :reservation

  before_validation :set_checkout_time

  validates_presence_of :reservation_id, :checked_out_at
  validate :item_was_properly_reserved

  attr_accessor :actual_user

private

  def set_checkout_time
    self.checked_out_at = Time.now
  end

  def item_was_properly_reserved
    # # !!! WORK IN PROGRESS
    # user = reservation.user
    # item = reservation.user
    # current_reservation = item.current_reservation
    # if current_reservation
    #   if current_reservation.user_id == user.id && item.in_use
    #     errors.add :base, "You have already checked out this item."
    #   elsif current_reservation.user_id != actual_user.id
    #     errors.add :base, "Another member has reserved the item until #{current_reservation.ending}. You may want to try reserving the item after than."
    #   end
    # else
    #   errors.add :base, 'You need to reserve an item before checking it out at this time.'
    #   next_reservation = self.next_reservation
    #   if next_reservation.nil?
    #     errors.add :base, 'This item has no future reservations.'
    #   elsif next_reservation.user_id == user.id
    #     errors.add :base, "You can check out this item at #{next_reservation.beginning}."
    #   else
    #     errors.add :base, "This item is booked for another member from #{next_reservation.beginning} to #{next_reservation.ending}. You may want to try to reserve it before than."
    #   end
    # end
  end

end