class Reservation < ActiveRecord::Base

  attr_accessor :slug
  belongs_to :playday
  belongs_to :user

  extend FriendlyId
    friendly_id :playday_id, use: :slugged
end