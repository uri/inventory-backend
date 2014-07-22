class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  has_one :checkout

  validate :beginning_less_than_ending
  validate :block_off_reserved_time_slot
  validates_presence_of :item_id, :user_id, :beginning, :ending

private

  def beginning_less_than_ending
    if beginning >= ending
      errors.add :base, 'Invalid beginning and ending dates.'
    end
  end


  # !!!
  # use this shortcut to simplify code:
  # http://makandracards.com/makandra/984-test-if-two-date-ranges-overlap-in-ruby-or-rails
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
