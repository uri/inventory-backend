class RemoveCheckedInAtAndCheckedOutAtFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :checked_in_at
    remove_column :reservations, :checked_out_at
  end
end
