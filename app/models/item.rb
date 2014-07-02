class Item < ActiveRecord::Base
  has_many :reservations
  belongs_to :category

  # !!!
  # Make sure that a user can pick up the item a bit
  # before if it's not in use. E.g. let time
  # DELTA be 10.minutes
  def current_reservation
    time_now = Time.now
    self.reservations
        .where('beginning <= ?', time_now)
        .where('ending    >= ?', time_now)
        .first
  end

  def checkout_with(user)
    reservation = current_reservation
    if reservation.nil?
      errors.add :base, 'You must reserve the item before the checkout.'
    else
      reservation_valid = ( reservation.user_id == user.id )
      if !reservation_valid
        errors.add :base, "This item has already been checked out by a different member. The reservation ends on #{reservation.ending}."
      elsif reservation_valid && !in_use
        item.update_attributes(in_use: true)
      elsif reservation_valid && in_use
        errors.add :base, 'You have already checked out this item.'
      end
    end
  end
end
