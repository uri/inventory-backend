class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  has_one :checkout

  validates_presence_of :item_id, :user_id, :beginning, :ending
  validate :beginning_less_than_ending
  validate :does_not_overlap

  scope :overlaps, ->(item_id, beginning, ending) do
    where(item_id: item_id).
    where('ending > ?', beginning).
    where('? > beginning', ending)
  end

private

  def beginning_less_than_ending
    if beginning >= ending
      errors.add :base, 'Invalid beginning and ending dates.'
    end
  end

  def does_not_overlap
    if Reservation.overlaps(item_id, beginning, ending).any?
      errors.add :base, 'The item is already reserved for a part of ' +
                        'this time period'
    end
  end
end
