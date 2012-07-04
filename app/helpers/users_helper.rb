module UsersHelper
  def self.termsofservice
    f = File.open("#{Rails.root}/config/locales/termsofservice." + "#{I18n.locale}", "r:utf-8")
    term = f.read
    f.close
    term
  end
  def self.termofpersonalinfomation
    t = File.open("#{Rails.root}/config/locales/termofpersonalinfomation." + "#{I18n.locale}", "r:utf-8")
    term = t.read
    t.close
    term
  end
end
