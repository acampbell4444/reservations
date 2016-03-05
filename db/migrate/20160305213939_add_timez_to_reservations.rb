class AddTimezToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :timez, :integer
  end
end
