class CreatePlaydays < ActiveRecord::Migration
  def change
    create_table :playdays do |t|
      t.integer :seven_am
      t.integer :eight_am
      t.integer :nine_am
      t.integer :ten_am
      t.integer :eleven_am
      t.integer :twelve_pm
      t.integer :one_pm
      t.integer :two_pm
      t.integer :three_pm
      t.integer :four_pm
      t.integer :five_pm
      t.integer :six_pm
      t.integer :seven_pm
      t.integer :eight_pm
      t.string :date

      t.timestamps null: false
    end
  end
end
