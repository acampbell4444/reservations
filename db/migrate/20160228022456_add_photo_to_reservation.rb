class AddPhotoToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :photo, :integer
  end
end
