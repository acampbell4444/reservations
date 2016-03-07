class AddFourThirtyPmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :four_thirty_pm, :integer
  end
end
