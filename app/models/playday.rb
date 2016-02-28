class Playday < ActiveRecord::Base

  has_many :reservations
  validates_presence_of :date

  extend FriendlyId
    friendly_id :date, use: :slugged


end
