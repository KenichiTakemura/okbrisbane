module Style
  
  PAGES = Hash.new
  SECTIONS = Hash.new
  NAVI = Hash.new
  PAGE_IDS = Hash.new
  SECTION_IDS = Hash.new
  
  # div id rule is banner_#{page}_#{section}_#{position}
  PAGES[:p_home] = "p_home"
  PAGES[:p_signin] = "p_signin"
  PAGES[:p_signup] = "p_signup"
  PAGES[:p_job] = "p_job"
  PAGES[:p_buy_and_sell] = "p_buy_and_sell"
  PAGES[:p_wellbeing] = "p_wellbeing"
  PAGES[:p_estate] = 'p_estate'
  PAGES[:p_business] = 'p_business'
  PAGES[:p_motor_vehicle] = 'p_motor_vehicle'
  PAGES[:p_accommodation] = 'p_accommodation'
  PAGES[:p_law] = 'p_law'
  PAGES[:p_tax] = 'p_tax'
  PAGES[:p_study] = 'p_study'
  PAGES[:p_immig] = 'p_immig'
  PAGES[:p_yellowpage] = 'p_yellowpage'
  PAGES[:p_sponsor] = "p_sponsor"
  PAGES[:p_mypage] = "p_mypage"
  PAGES[:p_signout] = "p_signout"
    
  PAGE_IDS[:p_home] = 1
  PAGE_IDS[:p_signin] = 2
  PAGE_IDS[:p_signup] = 3
  PAGE_IDS[:p_job] = 4
  PAGE_IDS[:p_buy_and_sell] = 5
  PAGE_IDS[:p_wellbeing] = 6
  PAGE_IDS[:p_estate] = 7
  PAGE_IDS[:p_business] = 8
  PAGE_IDS[:p_motor_vehicle] = 9
  PAGE_IDS[:p_accommodation] = 10
  PAGE_IDS[:p_law] = 11
  PAGE_IDS[:p_tax] = 12
  PAGE_IDS[:p_study] = 13
  PAGE_IDS[:p_immig] = 14
  PAGE_IDS[:p_yellowpage] = 15
  PAGE_IDS[:p_sponsor] = 16
  PAGE_IDS[:p_mypage] = 17
  PAGE_IDS[:p_signout] = 18
      
  NAVI[:p_job] = "p_job"
  NAVI[:p_buy_and_sell] = "p_buy_and_sell"
  NAVI[:p_wellbeing] = "p_wellbeing"
  NAVI[:p_study] = "p_study"
  NAVI[:p_immig] = "p_immig"
  NAVI[:p_estate] = "p_estate"
  NAVI[:p_law] = "p_law"
  NAVI[:p_tax] = "p_tax"
  NAVI[:p_yellowpage] = "p_yellowpage"
  
  SECTIONS[:s_header] = "s_header"
  SECTIONS[:s_background] = "s_background"
  SECTIONS[:s_body] = "s_body"

  SECTION_IDS[:s_header] = 1
  SECTION_IDS[:s_background] = 2
  SECTION_IDS[:s_body] = 3
  
  def Style.pages
    PAGES
  end
  
  def Style.sections
    SECTIONS
  end

  def Style.create_banner_div(page, section, position)
    "banner_#{Style.page(page)}_#{Style.section(section)}_#{position}"
  end

  def Style.pageid(key)
    PAGE_IDS[key] 
  end
  
  def Style.pagename(id)
    return nil if id.nil?
    p = PAGE_IDS.to_a
    p.rassoc(id.to_i).first.to_s
  end
  
  def Style.pagename_sym(id)
    return nil if id.nil?
    p = PAGE_IDS.to_a
    p.rassoc(id.to_i).first
  end
  
  def Style.sectionid(key)
    SECTION_IDS[key]
  end
  
  def Style.sectionname(id)
    return nil if id.nil?
    s = SECTION_IDS.to_a
    s.rassoc(id.to_i).first.to_s
  end
  
  def Style.sectionname_sym(id)
    return nil if id.nil?
    s = SECTION_IDS.to_a
    s.rassoc(id.to_i).first
  end
  
  def Style.page(key)
    Style::PAGES[key.to_sym]
  end
  
  def Style.section(key)
    Style::SECTIONS[key.to_sym]
  end

  
  Effect = Hash.new
  # Rule page _ section _ postion
  # if _ section _ position => any page
  Effect[:any] = ""
  Effect[:_s_header_1] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},pagination:false,fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},generatePagination:false,hoverPause:true|
  Effect[:_s_header_2] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},pagination:false,fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},generatePagination:false,hoverPause:true|
  Effect[:p_home_s_body_1] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},hoverPause:true,autoHeight:true,effect:'fade',crossfade: true,generateNextPrev:true|
  Effect[:p_home_s_body_3] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},hoverPause:true,generatePagination:false,effect:'fade',crossfade: true,generateNextPrev:false|

  def Style.getEffect(page, section, position)
    key = "#{page}_#{section}_#{position}"
    Rails.logger.debug("getEffect key: #{key}")
    effect = Effect[key.to_sym]
    return effect if !effect.nil?
    key = "_#{section}_#{position}"
    effect = Effect[key.to_sym]
    return effect if !effect.nil?
    key = "_#{position}"
    effect = Effect[key.to_sym]
    return effect if !effect.nil?
    Effect[:any]
  end

end
