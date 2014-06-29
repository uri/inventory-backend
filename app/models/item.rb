class Item < ActiveRecord::Base
  has_many :reservations
  belongs_to :category

  def current_reservation
    time_now = Time.now
    self.reservations
        .where('beginning <= ?', time_now)
        .where('ending    >= ?', time_now)
        .first
  end

  def checkout_by(user)
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
