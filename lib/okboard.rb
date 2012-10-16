module Okboard

  def self.dec(d)
    begin
      Common.decrypt_data(d)  
    rescue
      false
    end
  end
  
  def self.enc(d)
    Common.encrypt_data(d.to_s)
  end
  
  def self.param_v(v)
    #Rails.logger.debug("param_v v: #{v}")
    _d = dec(v)
    return nil if !_d
    #Rails.logger.debug("param_v d: #{d}")
    p = _d.split(SP)[1]
    #Rails.logger.debug("param_v p: #{p}")
    p
  end

  def self.param_to_s(p)
    d = dec(p)
    #Rails.logger.debug("okpage_p d: #{d}")
    d
  end
  
  def self.param_to_i(p)
    _d = dec(p)
    return nil if !_d
    d = _d.to_i
    #Rails.logger.debug("okpage_p d: #{d}")
    d
  end
  
  def self.param_enc(e)
    enc(e).chop if e.present?
  end
  
  def self.okpage_v(okpage)
    raise "Bad Request okpage nil" if okpage.nil?
    raise "Bad Request #{okpage}" if Style.page(okpage).nil?
    enc("#{Common.current_time.to_i}#{SP}#{okpage}").chop
  end

  def self.okboard_link(okpage)
    %Q|/okboards?v=| + okpage_v(okpage)
  end

  def self.okboard_link_with_id(okpage, id, post_search_id=nil)
    link = %Q|/okboards/view?v=| + okpage_v(okpage) + "&d=" + param_enc(id)
    link += "&s=" + param_enc(post_search_id) if post_search_id
    link
  end
  
  def self.okboard_url_with_id(url, okpage, id)
    url += "/view?v=" + okpage_v(okpage) + "&d=" + param_enc(id)
    url
  end

  def self.okboard_link_with_search(okpage, post_search_id)
    %Q|/okboards?v=| + okpage_v(okpage) + "&s=" + param_enc(post_search_id)
  end
  
  def self.okboard_link_write(okpage)
    %Q|/okboards/write?v=| + okpage_v(okpage)
  end
  
  def self.okboard_link_with_user(okpage, user)
    if !user.nil?
      %Q|/okboards/view?v=| + okpage_v(okpage) + "&u=" + param_enc(user)
    else
      okboard_link(okpage)
    end
  end
  
  def self.okboard_link_with_category(okpage,category)
    okboard_link(okpage) + "&c=" + enc(category)
  end

  def self.okboard_link_upload_image(okpage)
    %Q|/okboards/upload_image?v=| + okpage_v(okpage)
  end
  
  def self.okboard_link_delete_image(okpage)
    %Q|/okboards/delete_image?v=| + okpage_v(okpage) + "&id="
  end

  def self.okboard_link_delete_image_with_id_timestamp(okpage, id, timestamp)
    %Q|/okboards/delete_image?v=| + okpage_v(okpage) + "&id=#{id}&t=#{timestamp}"
  end
  
  def self.okboard_link_upload_attachment(okpage)
    %Q|/okboards/upload_attachment?v=| + okpage_v(okpage)
  end
  
  def self.okboard_link_delete_attachment(okpage)
    %Q|/okboards/delete_attachment?v=| + okpage_v(okpage) + "&id="
  end

  def self.okboard_link_delete_attachment_with_id_timestamp(okpage, id, timestamp)
    %Q|/okboards/delete_attachment?v=| + okpage_v(okpage) + "&id=#{id}&t=#{timestamp}"
  end
  
  def self.okboard_link_with_id_write_comment(okpage, id)
    %Q|/okboards/view?v=| + okpage_v(okpage) + "&d=" + param_enc(id) + "#new_comment"
  end
  
  def self.okboard_link_with_id_reply_comment(okpage, id)
    %Q|/okboards/view?v=| + okpage_v(okpage) + "&d=" + param_enc(id) + "#new_comment"
  end
  
  def self.okboard_link_like(okpage, id)
    %Q|/okboards/likes?v=| + okpage_v(okpage) + "&d=" + param_enc(id)
  end
  
  def self.okboard_link_dislike(okpage, id)
    %Q|/okboards/dislikes?v=| + okpage_v(okpage) + "&d=" + param_enc(id)
  end
  
  def self.okboard_link_abuse(okpage, id)
    %Q|/okboards/abuses?v=| + okpage_v(okpage) + "&d=" + param_enc(id)
  end
  
  def self.get_links(okpage)
    case okpage
    when :p_job
      links = [:p_job,:p_buy_and_sell,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
    when :p_buy_and_sell
      links = [:p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
    when :p_well_being
      links = [:p_well_being,:p_job,:p_buy_and_sell,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
    when :p_estate
      links = [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig]
    when :p_motor_vehicle
      links = [:p_motor_vehicle,:p_estate,:p_business,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig]
    when :p_business
      links = [:p_business,:p_estate,:p_motor_vehicle,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig]
    when :p_accommodation
      links = [:p_accommodation,:p_estate,:p_motor_vehicle,:p_business,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig]
    when :p_law
      links = [:p_law,:p_tax,:p_study,:p_immig,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
    when :p_tax
      links = [:p_tax,:p_law,:p_study,:p_immig,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
    when :p_study
      links = [:p_study,:p_law,:p_tax,:p_immig,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
    when :p_immig
      links = [:p_immig,:p_law,:p_tax,:p_study,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
    when :p_yellowpage
      links = [:p_yellowpage,:p_law,:p_tax,:p_study,:p_immig,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
    when :p_mypage
      links = [:p_job,:p_buy_and_sell,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
    when :p_sponsor
      links = [:p_job,:p_buy_and_sell,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
    else
      raise "Not implemented"
    end
    links
  end
  
  def self.get_links_i18n_list(okpage)
    get_links(okpage).collect{ |l| [I18n.t(Style.page(l)),l]}
  end
  
  private
  
  SP = "+"
  
end