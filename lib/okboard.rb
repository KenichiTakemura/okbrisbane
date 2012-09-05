module Okboard

  def self._okpage_v(okpage)
    raise "Bad Request #{okpage}" if Style.page(okpage).nil?
    Common.encrypt_data(okpage.to_s).chop
  end

  def self.okboard_link(okpage)
    %Q|/okboards?v=| + _okpage_v(okpage)
  end

  def self.okboard_link_with_search(okpage, post_search)
    %Q|/okboards?v=| + _okpage_v(okpage) + "&s=" + Common.encrypt_data(post_search.to_s).html_safe
  end
  
  def self.okboard_link_write(okpage)
    %Q|/okboards/write?v=| + _okpage_v(okpage)
  end
  
  def self.okboard_link_with_id(okpage, id)
    %Q|/okboards/view?v=| + _okpage_v(okpage) + "&d=" + Common.encrypt_data(id.to_s).html_safe
  end

  def self.okboard_link_with_id_write_comment(okpage, id)
    %Q|/okboards/view?v=| + _okpage_v(okpage) + "&d=" + Common.encrypt_data(id.to_s).html_safe + "#new_comment"
  end
  
  def self.okboard_link_with_id_reply_comment(okpage, id)
    %Q|/okboards/view?v=| + _okpage_v(okpage) + "&d=" + Common.encrypt_data(id.to_s).html_safe + "#new_comment"
  end
  
  def self.okboard_link_like(okpage, id)
    %Q|/okboards/likes?v=| + _okpage_v(okpage) + "&d=" + Common.encrypt_data(id.to_s).html_safe
  end
  
  def self.okboard_link_dislike(okpage, id)
    %Q|/okboards/dislikes?v=| + _okpage_v(okpage) + "&d=" + Common.encrypt_data(id.to_s).html_safe
  end
  
  def self.okboard_link_abuse(okpage, id)
    %Q|/okboards/abuses?v=| + _okpage_v(okpage) + "&d=" + Common.encrypt_data(id.to_s).html_safe
  end
  
end