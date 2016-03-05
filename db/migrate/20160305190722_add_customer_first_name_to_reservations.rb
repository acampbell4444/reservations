class AddCustomerFirstNameToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :customer_first_name, :string
  end
end
