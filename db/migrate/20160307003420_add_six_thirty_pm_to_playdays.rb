class AddSixThirtyPmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :six_thirty_pm, :integer
  end
end
