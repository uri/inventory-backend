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

  def next_reservation_for(member)
    self.reservations
        .where(user_id: member.id)
        .where('beginning >= ?', Time.now)
        .order('beginning ASC').first
  end

end
