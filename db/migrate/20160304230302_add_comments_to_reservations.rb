class AddCommentsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :comments, :string
  end
end
