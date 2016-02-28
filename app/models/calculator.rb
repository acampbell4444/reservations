class Calculator < ActiveRecord::Base

  def total_estimate
    six + eight + photo
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

  def photo
    if self.photo_package.nil?
      0
    else
      30*(self.photo_package)
    end
  end

  def discount
#enter discount logic here
  end





    #(:six_hundred, :eight_hundred, :discount_code, :photo_package)

end
