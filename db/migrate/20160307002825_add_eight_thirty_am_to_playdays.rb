class AddEightThirtyAmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :eight_thirty_am, :integer
  end
end
