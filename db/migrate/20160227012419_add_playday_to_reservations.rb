class AddPlaydayToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :playday_id, :integer
    add_index :reservations, :playday_id
  end
end
