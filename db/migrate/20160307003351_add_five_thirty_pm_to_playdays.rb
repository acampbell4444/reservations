class AddFiveThirtyPmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :five_thirty_pm, :integer
  end
end
