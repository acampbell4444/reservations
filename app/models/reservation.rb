class Reservation < ActiveRecord::Base

  attr_accessor :slug
  before_save :military_time
  after_create :update_playday_slots
  #after_create :new_reservation
  #after_update :update_reservation

  belongs_to :user
  validates :six_hundred, :inclusion => {:in => 0..15}, presence: true
  validates :eight_hundred, :inclusion => {:in => 0..15}, presence: true
  validates :time, presence: true
  validates :customer_email,presence: true
  validates :customer_first_name,presence: true
  validates :customer_last_name,presence: true
  validates :customer_phone_number,presence: true
  validates :user, presence: true


  default_scope { order('date DESC') }
  default_scope { order('timez ASC') }

def military_time
  case self.time
  when "8 am"
    self.timez = 800
  when "830 am"
    self.timez = 830
  when "9 am"
    self.timez = 900
  when "930 am"
    self.timez = 930
  when "10 am"
    self.timez = 1000
  when "1030 am"
    self.timez = 1030
  when "11 am"
    self.timez = 1100
  when "1130 am"
    self.timez = 1130
  when "12 pm"
    self.timez = 1200
  when "1230 pm"
    self.timez = 1230
  when "1 pm"
    self.timez = 1300
  when "130 pm"
    self.timez = 1330
  when "2 pm"
    self.timez = 1400
  when "230 pm"
    self.timez = 1430
  when "3 pm"
    self.timez = 1500
  when "330 pm"
    self.timez = 1530
  when "4 pm"
    self.timez = 1600
  when "430 pm"
    self.timez = 1630
  when "5 pm"
    self.timez = 1700
  when "530 pm"
    self.timez = 1730
  when "6 pm"
    self.timez = 1800
  when "630 pm"
    self.timez = 1830
  when "7 pm"
    self.timez = 1900
  when "730 pm"
    self.timez = 1930
  end
end

  extend FriendlyId
    friendly_id :playday_id, use: :slugged

    time = {
      "8 am" => 800,
      "830 am" => 830,
      "9 am" => 900,
      "930 am" => 930,
      "10 am" => 1000,
      "1030 am" => 1030,
      "11 am" => 1100,
      "1130 am" => 1130,
      "12 pm" => 1200,
      "1230 pm" => 1230,
      "1 pm" => 1300,
      "130 pm" => 1330,
      "2 pm" => 1400,
      "230 pm" => 1430,
      "3 pm" => 1500,
      "330 pm" => 1530,
      "4 pm" => 1600,
      "430 pm" => 1630,
      "5 pm" => 1700,
      "530 pm" => 1730,
      "6 pm" => 1800,
      "630 pm" => 1830,
      "7 pm" => 1900,
      "730 pm" => 1930,
      "8 pm" => 2000,
    }

  def update_playday_slots
    times = {
      "8 am" => "eight_am",
      "830 am" => "eight_thirty_am",
      "9 am" => "nine_am",
      "930 am" => "nine_thirty_am",
      "10 am" => "ten_am",
      "1030 am" => "ten_thirty_am",
      "11 am" => "eleven_am",
      "1130 am" => "eleven_thirty_am",
      "12 pm" => "twelve_pm",
      "1230 pm" => "twelve_thirty_pm",
      "1 pm" => "one_pm",
      "130 pm" => "one_thirty_pm",
      "2 pm" => "two_pm",
      "230 pm" => "two_thirty_pm",
      "3 pm" => "three_pm",
      "330 pm" => "three_thirty_pm",
      "4 pm" => "four_pm",
      "430 pm" => "four_thirty_pm",
      "5 pm" => "five_pm",
      "530 pm" => "five_thirty_pm",
      "6 pm" => "six_pm",
      "630 pm" => "six_thirty_pm",
      "7 pm" => "seven_pm",
      "730 pm" => "seven_thirty_pm",
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

  def new_reservation
    NewreservationMailer.new_reservation(self).deliver_now
  end

  def update_reservation
    UpdateReservationMailer.update_reservation(self).deliver_now
  end

  def six
    if self.six_hundred.nil?
      0
    else
      65*(self.six_hundred)
    end
  end

  def total_flights
    (self.six_hundred || 0) + (self.eight_hundred || 0)
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

  def discount_codes
  end
end
