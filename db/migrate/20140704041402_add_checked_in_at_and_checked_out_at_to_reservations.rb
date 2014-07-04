class AddCheckedInAtAndCheckedOutAtToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :checked_in_at, :datetime
    add_column :reservations, :checked_out_at, :datetime
  end
end
