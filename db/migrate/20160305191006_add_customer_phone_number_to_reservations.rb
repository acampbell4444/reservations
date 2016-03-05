class AddCustomerPhoneNumberToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :customer_phone_number, :string
  end
end
