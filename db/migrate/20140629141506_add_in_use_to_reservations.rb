class AddInUseToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :in_use, :boolean
  end
end
