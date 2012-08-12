class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  # attr_accessible :title, :body
  
  has_one :mypage, :dependent => :destroy
  has_many :job, :as => :posted_by, :class_name => 'Job', :dependent => :destroy
  has_many :buy_and_sell, :as => :posted_by, :class_name => 'BuyAndSell', :dependent => :destroy
  has_many :comment, :as => :commented_by, :dependent => :destroy      
  has_many :attachment, :as => :attached_by, :class_name => 'Attachment', :dependent => :destroy
  has_many :image, :as  => :attached_by, :class_name => 'Image', :dependent => :destroy
    
  after_create :create_mypage
  
  def name
    return "#{self.last_name} #{self.first_name}" if !self.first_name.empty?
    return "#{self.last_name}" if !self.last_name.empty?
    ""
  end
  
  def create_mypage
    logger.info("User created: " << self.to_s)
    m = Mypage.create()
    m.update_attribute(:user, self)
  end
  
  def nologin?
    Mypage.find_by_mypagable_id(self).nologin
  end
  
  def to_s
    "id: " << id << " email: " << email
  end
  
end
