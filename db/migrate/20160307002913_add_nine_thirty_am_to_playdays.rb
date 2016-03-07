class AddNineThirtyAmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :nine_thirty_am, :integer
  end
end
