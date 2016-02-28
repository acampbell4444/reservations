class CreateCalculators < ActiveRecord::Migration
  def change
    create_table :calculators do |t|
      t.integer :eight_hundred
      t.integer :six_hundred
      t.string :discount_code
      t.integer :photo_package

      t.timestamps null: false
    end
  end
end
