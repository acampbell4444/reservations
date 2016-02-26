class AddSlugToPlaydays < ActiveRecord::Migration
  def change
    add_column :playdays, :slug, :string
    add_index :playdays, :slug
  end
end
