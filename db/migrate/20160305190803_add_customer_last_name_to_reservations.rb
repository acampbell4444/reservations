class AddCustomerLastNameToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :customer_last_name, :string
  end
end
