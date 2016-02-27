class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :email
      t.integer :six_hundred
      t.integer :eight_hundred
      t.string :date
      t.string :time

      t.timestamps null: false
    end
  end
end
