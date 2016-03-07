class AddSevenThirtyPmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :seven_thirty_pm, :integer
  end
end
