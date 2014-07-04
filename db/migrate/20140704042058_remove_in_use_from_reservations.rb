class RemoveInUseFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :in_use
  end
end
