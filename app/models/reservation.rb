class Reservation < ActiveRecord::Base
  belongs_to :playday
  belongs_to :user

  def total_price
    (self.six_hundred * 65) + (self.eight_hundred * 75)
  end
end
