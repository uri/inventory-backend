class Item < ActiveRecord::Base
  has_many :reservations, dependent: :destroy
  belongs_to :category

  # !!!
  # Make sure that a user can pick up the item a bit
  # before if it's not in use. E.g. let time
  # DELTA be 10.minutes
  def current_reservation
    current_time = Time.now
    self.reservations
        .where('beginning <= ?', current_time)
        .where('ending    >= ?', current_time)
        .first
  end

  def next_reservation
    self.reservations
        .where('beginning >= ?', Time.now)
        .order('beginning ASC').first
  end

  # !!!
  # This method isn't called from anywhere
  def checkout_with(user)
    current_reservation = self.current_reservation
    if current_reservation
      if current_reservation.user_id == user.id && !item.in_use
        self.checkout.create
      elsif current_reservation.user_id == user.id && item.in_use
        errors.add :base, "You have already checked out this item."
      else
        errors.add :base, "Another member has reserved the item until #{current_reservation.ending}. You may want to try reserving the item after than."
      end
    else
      errors.add :base, 'You need to reserve an item before checking it out at this time.'
      next_reservation = self.next_reservation
      if next_reservation.nil?
        errors.add :base, 'This item has no future reservations.'
      elsif next_reservation.user_id == user.id
        errors.add :base, "You can check out this item at #{next_reservation.beginning}."
      else
        errors.add :base, "This item is booked for another member from #{next_reservation.beginning} to #{next_reservation.ending}. You may want to try to reserve it before than."
      end
    end
  end

end
