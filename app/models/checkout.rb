class Checkout < ActiveRecord::Base
  belongs_to :reservation
  has_one :item, through: :reservation

  attr_accessor :member

  before_validation :set_checkout_time
  after_save :mark_item_as_in_use

  validates_presence_of :reservation_id, :checked_out_at, :member
  validate :item_was_properly_reserved, if: Proc.new{|c| c.reservation && c.member}

private

  def item_was_properly_reserved
    current_reservation = item.current_reservation
    if current_reservation
      if current_reservation.user == member && item.in_use
        errors.add :base, "You have already checked out this item."
      elsif current_reservation.user != member
        errors.add :base, "Another member has this item reserved until #{current_reservation.ending}."
      end
    else
      members_next_reservation = item.next_reservation_for(member)
      if members_next_reservation
        errors.add :base, "You can check this item out at #{members_next_reservation.beginning} or try to reserve it for an earlier time."
      else
        errors.add :base, "You need to reserve the item before cheking it out."
      end
    end
  end

  def set_checkout_time
    self.checked_out_at = Time.now
  end

  def mark_item_as_in_use
    item.update_attributes(in_use: true)
  end
end