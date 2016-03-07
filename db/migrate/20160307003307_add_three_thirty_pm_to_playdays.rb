class AddThreeThirtyPmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :three_thirty_pm, :integer
  end
end
