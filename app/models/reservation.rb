class Reservation < ActiveRecord::Base

  attr_accessor :slug

  belongs_to :user
  validates :six_hundred, :inclusion => {:in => 0..15}, presence: true
  validates :eight_hundred, :inclusion => {:in => 0..15}, presence: true
  validates :time, presence: true

  validates :date, presence: true
  validates :user, presence: true

  after_create :update_playday_slots
  default_scope { order('date ASC') }



  extend FriendlyId
    friendly_id :playday_id, use: :slugged





  def update_playday_slots
    times = {
      "8 am" => "eight_am",
      "9 am" => "nine_am",
      "10 am" => "ten_am",
      "11 am" => "eleven_am",
      "12 pm" => "twelve_pm",
      "1 pm" => "one_pm",
      "2 pm" => "two_pm",
      "3 pm" => "three_pm",
      "4 pm" => "four_pm",
      "5 pm" => "five_pm",
      "6 pm" => "six_pm",
      "7 pm" => "seven_pm",
      "8 pm" => "eight_pm",
    }

    @playday = Playday.find_by! date: date
    date = self.date
    six = self.six_hundred || 0
    eight = self.eight_hundred || 0
    total_reservations = six + eight
    attribute = times[self.time]
    @playday.update_attribute(attribute, @playday.send(attribute) - total_reservations)
  end

  def total_estimate
    six + eight + photos #-discount
  end

  def six
    if self.six_hundred.nil?
      0
    else
      65*(self.six_hundred)
    end
  end

  def eight
    if self.eight_hundred.nil?
      0
    else
      75*(self.eight_hundred)
    end
  end

  def photos
    if self.photo.nil?
      0
    else
      30*(self.photo)
    end
  end

  def discount
#enter discount logic here
  end
end
