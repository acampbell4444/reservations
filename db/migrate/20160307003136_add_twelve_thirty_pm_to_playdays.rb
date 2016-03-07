class AddTwelveThirtyPmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :twelve_thirty_pm, :integer
  end
end
