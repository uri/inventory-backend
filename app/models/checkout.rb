class Checkout < ActiveRecord::Base
  belongs_to :reservation

  attr_accessor :member

  before_validation :set_checkout_time

  validates_presence_of :reservation_id, :checked_out_at
  validate :item_was_properly_reserved, if: Proc.new{|c| c.reservation}

private

  def item_was_properly_reserved
    item = reservation.item
    current_reservation = item.current_reservation
    if current_reservation
      if current_reservation.user == member && item.in_use
        errors.add :base, "You have already checked out this item."
      elsif current_reservation.user != member
        errors.add :base, "Another member has this item reserved until #{current_reservation.ending}. You may want to reserving the item after than."
      end
    else
      errors.add :base, 'You need to reserve an item before checking it out at this time.'
      next_reservation = reservation.item.next_reservation
      if next_reservation.nil?
        errors.add :base, 'This item has no future reservations.'
      elsif next_reservation.user == member
        errors.add :base, "You can check out this item at #{next_reservation.beginning}."
      else
        errors.add :base, "This item is booked for another member from #{next_reservation.beginning} to #{next_reservation.ending}. You may want to try to reserve it before or after than."
      end
    end
  end

  def set_checkout_time
    self.checked_out_at = Time.now
  end
end