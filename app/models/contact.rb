class Contact < ActiveRecord::Base
  # belongs_to
  belongs_to :contacted_by, :polymorphic => true

  attr_accessible :email, :user_name, :phone, :contact_type, :body
  

  validates_presence_of :email
  validates_presence_of :user_name
  validates_presence_of :phone
  validates_presence_of :contact_type
  validates_presence_of :body
  validates_format_of :email, :with => Okvalue::EMAIL_REGEXP, :if => Proc.new { |email| email.present? }
  validates_format_of :phone, :with => /\A[\+\d\-\(\)\sx]+\z/, :if => Proc.new { |phone| phone.present? }

  def category_list()
    list = Array.new
    list.push([I18n.t(:contact_banner),Okvalue::CONTACT_BANNER])
    list.push([I18n.t(:contact_general),Okvalue::CONTACT_GENERAL])
    list.push([I18n.t(:contact_feedback),Okvalue::CONTACT_FEEDBACK])
    list.push([I18n.t(:contact_issue),Okvalue::CONTACT_ISSUE])
    list.push([I18n.t(:contact_exit),Okvalue::CONTACT_EXIT])
    list
  end
  
  def contact_type_name
    case contact_type
    when Okvalue::CONTACT_BANNER
      return I18n.t(:contact_banner)
    end
  end
  
  def set_user(user)
    update_attribute(:contacted_by, user)
  end
  
end
