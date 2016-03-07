class AddTwoThirtyPmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :two_thirty_pm, :integer
  end
end
