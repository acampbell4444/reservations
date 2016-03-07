class AddElevenThirtyAmToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :eleven_thirty_am, :integer
  end
end
