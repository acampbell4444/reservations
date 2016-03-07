class AddEightThirtyToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :eight_thirty, :integer
  end
end
