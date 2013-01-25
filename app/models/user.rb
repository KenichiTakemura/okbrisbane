class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable, :confirmable, :timeoutable, :omniauthable
  #:validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_name, :is_special, :confirmed_at
  attr_accessible :agreed_on, :provider, :uid

  has_one :mypage, :as => :mypagable, :class_name => "Mypage", :dependent => :destroy
  has_many :role, :as => :rolable, :class_name => "Role", :dependent => :destroy
  has_many :post_searches, :as => :searchable, :class_name => "PostSearch", :dependent => :destroy
  has_many :post, :as => :posted_by
  has_many :job, :as => :posted_by, :class_name => 'Job', :dependent => :destroy
  has_many :buy_and_sell, :as => :posted_by, :class_name => 'BuyAndSell', :dependent => :destroy
  has_many :well_being, :as => :posted_by, :class_name => 'WellBeing', :dependent => :destroy
  has_many :comment, :as => :commented_by, :dependent => :destroy
  has_many :attachment, :as => :attached_by, :class_name => 'Attachment', :dependent => :destroy
  has_many :image, :as  => :attached_by, :class_name => 'Image', :dependent => :destroy
  has_many :contact, :as => :contacted_by

  PROVIDERS = Hash.new
  PROVIDERS[:facebook] = "facebook"
  PROVIDERS[:google] = "google_oauth2"
  PROVIDERS[:naver] = "naver"
  PROVIDERS[:okbrisbane] = "okbrisbane"

  #https://github.com/plataformatec/devise/blob/master/lib/devise/models/validatable.rb
  validates_presence_of :email
  #validates_uniqueness_of :email, :allow_blank => true, :if => :email_changed?
  validates_format_of :email, :with => Devise::email_regexp, :allow_blank => true

  validates_presence_of :password
  validates_confirmation_of :password
  validates_length_of :password, :within => Devise::password_length, :allow_blank => true

  #Custom
  validates_presence_of :user_name
  validates_presence_of :provider

  after_create :create_mypage, :init_role
  after_initialize :provider_ok
  def provider_ok
    self.provider ||= PROVIDERS[:okbrisbane]
  end

  def facebook_user?
    self.provider.eql?(PROVIDERS[:facebook])
  end

  def google_user?
    self.provider.eql?(PROVIDERS[:google])
  end

  def naver_user?
    self.provider.eql?(PROVIDERS[:naver])
  end

  def okbrisbane_user?
    self.provider.eql?(PROVIDERS[:okbrisbane])
  end

  def name
    user_name
  end

  def agreed?
    return false if !self.agreed_on.present?
    self.agreed_on > Okvalue::TERMS_DATE
  end

  def agree
    self.update_attribute(:agreed_on, Common.current_time)
  end

  def init_role
    [:p_job,:p_buy_and_sell,:p_well_being].each do |page|
      role = Role.new(:role_name => Style.page(page), :role_value => Role::R[:user_all])
      role.assign(self)
    end
  end

  def can_write?(page)
    self.role.each do |r|
      return true if r.role_name.eql?(Style.page(page)) && r.has_role?(Role::R[:user_w])
    end
    false
  end

  def create_mypage
    logger.info("User created: " << self.to_s)
    m = Mypage.create()
    m.update_attribute(:mypagable, self)
  end

  def to_s
    "id: #{id} name: #{name} email: #{email}"
  end

  def unattached_image
    Image.where("attached_by_id = ? AND attached_id is NULL AND write_at is not NULL", self.id)
  end

  def unattached_attachment
    Attachment.where("attached_by_id = ? AND attached_id is NULL AND write_at is not NULL", self.id)
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    logger.info("find_for_facebook_oauth #{auth.provider} #{auth.uid}")
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if !user.present?
      user_name = auth.extra.raw_info.name
      password = Devise.friendly_token[0,20]
      logger.info("User is to be created. email: #{user_name} #{auth.info.email}")
      user = User.new(:user_name => user_name,
      :provider => auth.provider,
      :uid => auth.uid,
      :email => auth.info.email,
      :password => password,
      :password_confirmation => password,
      #:_image => auth.info.image,
      #:flyer_url => auth.extra.raw_info.link,
      :confirmed_at => Common.current_time)
      if !user.save
        logger.error(user.errors.full_messages)
      end
    else
      if user.locked?
        logger.info("Use is locked")
        return nil
      end
      if user.mypage.present?
        user.mypage.update_attribute(:user_image, auth.info.image) if auth.info.image.present?
        user.mypage.update_attribute(:user_url, auth.extra.raw_info.link) if auth.extra.raw_info.link.present?
      end
    end
    user
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    logger.info("find_for_google_oauth2 access_token: #{access_token}")
    data = access_token.info
    provider = access_token.provider
    uid = access_token.uid
    link = access_token.extra.raw_info.link
    picture = access_token.extra.raw_info['picture']
    email = data["email"]
    logger.info("find_for_google_oauth2 #{provider} #{uid} #{link} #{email} #{picture}")
    # I should say adding provider check because one can signin Facebook with gmail account
    user = User.where(:provider => provider, :uid => uid).first
    if !user.present?
      logger.info("User is to be created. email: #{data["email"]}")
      password = Devise.friendly_token[0,20]
      user = User.create(:user_name => data["name"],
      :provider => provider,
      :uid => uid,
      :email => email,
      :password => password,
      :password_confirmation => password,
      :confirmed_at => Common.current_time
    )
    else
      if user.locked?
        logger.info("Use is locked")
        return nil
      end
      if user.mypage.present?
        user.mypage.update_attribute(:user_image, picture) if picture.present?
        user.mypage.update_attribute(:user_url, link) if link.present?
      end
    end
    user
  end

  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_first_by_auth_conditions(warden_conditions)
    logger.info("find_first_by_auth_conditions warden_conditions: #{warden_conditions}")
    conditions = warden_conditions.dup
    Rails.logger.debug("find_first_by_auth_conditions: #{conditions}")
    if email = conditions.delete(:email)
      where(conditions).where(["provider = :provider AND lower(email) = :value AND locked_at is NULL", { :provider => User::PROVIDERS[:okbrisbane], :value => email.downcase }]).first
    else
      where(conditions).first
    end
  end

  def user_url
    mypage.user_url
  end

  def user_image
    mypage.user_image
  end

  def locked?
    locked_at.present?
  end

end
