class User < ActiveRecord::Base
  has_many :reservations
  has_many :roles
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :phone, :presence => true,
                 :length => { :minimum => 10, :maximum => 15 }

  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  def admin_premium?
    role == 'premium' || role == 'admin'
  end

  def standard!
    update(role: 'standard')
  end

  def premium!
    update(role: 'premium')
  end

  def admin!
    update(role: 'admin')
  end


  private

  def set_default_role
    self.role ||= 'standard'
  end
end
