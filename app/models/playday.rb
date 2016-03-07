class Playday < ActiveRecord::Base

  validates_presence_of :date

  extend FriendlyId
    friendly_id :date, use: :slugged

    default_scope { order('date ASC') }

    def dirty_thirties_off?
      (eight_thirty_am == 0) && (nine_thirty_am == 0) && (ten_thirty_am == 0) && (eleven_thirty_am == 0) && (twelve_thirty_pm == 0) && (one_thirty_pm == 0)&& (two_thirty_pm == 0) && (three_thirty_pm == 0) && (four_thirty_pm == 0) && (five_thirty_pm == 0) && (six_thirty_pm == 0) && (seven_thirty_pm == 0)
    end

end
