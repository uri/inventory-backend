class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validate :beginning_less_than_ending
  validate :block_off_reserved_time_slot

  def activate
    update_attributes(checked_out_at: Time.now)
  end

private

  # !!!
  def beginning_less_than_ending
  end


  # !!!
  # refactor in several small methods
  def block_off_reserved_time_slot
    items_reservations = Reservation.where(item_id: self.item_id)

    overlaps_on_the_left = items_reservations.
      where('beginning <= ? AND ending > ?',
        self.beginning, self.beginning).
      any?

    overlaps_on_the_right = items_reservations.
      where('beginning < ? AND ending >= ?',
        self.ending, self.ending).
      any?

    completely_covers_existing = items_reservations.
      where('? <= beginning AND ending <= ?',
        self.beginning, self.ending).
      any?

    is_inside_existing = items_reservations.
      where('beginning <= ? AND ? <= ending',
        self.beginning, self.ending).
      any?

    if  overlaps_on_the_left ||
        overlaps_on_the_right ||
        completely_covers_existing ||
        is_inside_existing
      errors.add :base,
        'The time interval is in conflict with someone else\'s reservation'
    end
  end
end
