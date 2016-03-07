class AddOneThirtyPmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :one_thirty_pm, :integer
  end
end
