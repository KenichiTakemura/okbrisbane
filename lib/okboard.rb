module Okboard

  def self._okpage_v(okpage)
    raise "Bad Request #{okpage}" if Style.page(okpage).nil?
    Common.encrypt_data(okpage.to_s).chop
  end

  def self.okboard_link(okpage)
    %Q|/okboards?v=| + _okpage_v(okpage)
  end
  
  def self.okboard_link_with_id(okpage, id)
    %Q|/okboards/view?v=| + _okpage_v(okpage) + "&d=" + Common.encrypt_data(id.to_s).html_safe
  end
end