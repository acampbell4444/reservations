class AddDiscountToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :discount, :string
  end
end
