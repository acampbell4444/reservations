class AddCustomerEmailToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :customer_email, :string
  end
end
