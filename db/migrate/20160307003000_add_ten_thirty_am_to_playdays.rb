class AddTenThirtyAmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :ten_thirty_am, :integer
  end
end
