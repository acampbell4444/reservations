class Playday < ActiveRecord::Base

  validates_presence_of :date

  extend FriendlyId
    friendly_id :date, use: :slugged


end
