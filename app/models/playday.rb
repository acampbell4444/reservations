class Playday < ActiveRecord::Base
  extend FriendlyId
    friendly_id :date, use: :slugged
  def self.search(search)
    where("date like ?", "%#{search}%")
    #can add another search field here, like:
    #where("content LIKE ?", "%#{search}%")
end

end
