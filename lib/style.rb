module Style
  
  PAGES = Hash.new
  SECTIONS = Hash.new
  PAGE_IDS = Hash.new
  SECTION_IDS = Hash.new
  
  # div id rule is banner_#{page}_#{section}_#{position}
  PAGES[:p_home] = "Home"
  PAGES[:p_signin] = "Signin"
  PAGES[:p_signup] = "Signup"
  PAGES[:p_job] = "Job"
  PAGES[:p_buy_and_sell] = "BuyAndSell"
  PAGES[:p_well_being] = "WellBeing"
  PAGES[:p_estate] = 'Estate'
  PAGES[:p_business] = 'Business'
  PAGES[:p_motor_vehicle] = 'MotorVehicle'
  PAGES[:p_accommodation] = 'Accommodation'
  PAGES[:p_law] = 'Law'
  PAGES[:p_tax] = 'Tax'
  PAGES[:p_study] = 'Study'
  PAGES[:p_immig] = 'Immigration'
  PAGES[:p_yellowpage] = 'Yellowpage'
  PAGES[:p_sponsor] = "Sponsor"
  PAGES[:p_mypage] = "Mypage"
  PAGES[:p_signout] = "Signout"
  PAGES[:p_issue] = "Issue"
    
  PAGE_IDS[:p_home] = 1
  PAGE_IDS[:p_signin] = 2
  PAGE_IDS[:p_signup] = 3
  PAGE_IDS[:p_job] = 4
  PAGE_IDS[:p_buy_and_sell] = 5
  PAGE_IDS[:p_well_being] = 6
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
  PAGE_IDS[:p_issue] = 19
   
   
  NAVI = [:p_job, :p_buy_and_sell, :p_well_being, :p_study, :p_immig, :p_estate, :p_law, :p_tax, :p_yellowpage]
  
  SECTIONS[:s_header] = "s_header"
  SECTIONS[:s_background] = "s_background"
  SECTIONS[:s_body] = "s_body"

  SECTION_IDS[:s_header] = 1
  SECTION_IDS[:s_background] = 2
  SECTION_IDS[:s_body] = 3
  
  def Style.pages
    PAGES
  end
  
  def Style.banner_pages
    pages = PAGES.clone
    pages.delete(:p_issue)
    pages
  end
  
  def Style.sections
    SECTIONS
  end

  def Style.create_banner_div(page, section, position)
    "banner_#{Style.page(page)}_#{Style.section(section)}_#{position}"
  end

  def Style.pageid_value(value)
    PAGE_IDS[PAGES.index value] 
  end
  
  def Style.pageid_key(key)
    PAGE_IDS[key]
  end
  
  def Style.pagename(id)
    return nil if id.nil?
    PAGES[PAGE_IDS.index id.to_i]
  end
  
  def Style.pagename_sym(id)
    return nil if id.nil?
    PAGE_IDS.index id.to_i
  end
  
  def Style.sectionid(key)
    SECTION_IDS[key]
  end
  
  def Style.sectionname(id)
    return nil if id.nil?
    SECTIONS[SECTION_IDS.index id.to_i]
  end
  
  def Style.sectionname_sym(id)
    return nil if id.nil?
    SECTION_IDS.index id.to_i
  end
  
  def Style.page(key)
    Style::PAGES[key.to_sym]
  end
  
  def Style.section(key)
    Style::SECTIONS[key.to_sym]
  end
  
  def Style.m2s(model)
    PAGES.index model
  end
  
  Effect = Hash.new
  # Rule page _ section _ postion
  # if _ section _ position => any page
  Effect[:any] = ""
  Effect[:_s_header_1] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},pagination:false,fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},generatePagination:false,hoverPause:true|
  Effect[:_s_header_2] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},pagination:false,fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},generatePagination:false,hoverPause:true|
  Effect[:Home_s_body_1] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},hoverPause:true,autoHeight:true,effect:'fade',crossfade: true,generateNextPrev:true|
  Effect[:Home_s_body_3] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},hoverPause:true,generatePagination:false,effect:'fade',crossfade: true,generateNextPrev:false|

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
  
  def Style.create_banners
    Style.banner_pages.each do |key, value|
      ## Header
      if value.eql? Style.page(:p_home)
        effect = Banner::E_SLIDE
      else
        effect = Banner::E_FIX
      end
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_header),
      :position_id => 1,
      :div_width => 500, :div_height => 60, :img_width => 500,
      :img_height => 60, :style => 'position:relative;float:right;top:0px;',
      :effect => Banner::E_FIX)
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_header),
      :position_id => 2,
      :div_width => 710, :div_height => 120, :img_width => 710, :img_height => 120,
      :style => 'position:relative;float:right;right:0px',
      :effect => effect)
      if value.eql? Style.page(:p_home)
        is_disabled = false
      else
        is_disabled = true
      end
      ## Background
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_background),
      :position_id => 1,
      :div_width => 160, :div_height => 800,
      :img_width => 160, :img_height => 800,
      :style => 'position:absolute;top:100px;left:-165px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_background),
      :position_id => 2,
      :div_width => 160, :div_height => 800,
      :img_width => 160, :img_height => 800,
      :style => 'position:absolute;top:100px;right:-165px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_background),
      :position_id => 3,
      :div_width => 160, :div_height => 800,
      :img_width => 160, :img_height => 800,
      :style => 'position:absolute;top:950px;left:-165px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_background),
      :position_id => 4,
      :div_width => 160, :div_height => 800,
      :img_width => 160, :img_height => 800,
      :style => 'position:absolute;top:950px;right:-165px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_background),
      :position_id => 5,
      :div_width => 160, :div_height => 800,
      :img_width => 160, :img_height => 800,
      :style => 'position:absolute;top:1800px;left:-165px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_background),
      :position_id => 6,
      :div_width => 160, :div_height => 800,
      :img_width => 160, :img_height => 800,
      :style => 'position:absolute;top:1800px;right:-165px',
      :is_disabled => is_disabled)
    end
    # Home
    _page = :p_home
    ## Body
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id =>1,
    :div_width => 650, :div_height => 400,
    :img_width => 650, :img_height => 380,
    :style => 'position:relative;float:left;top:0px',
    :effect => Banner::E_SLIDE);
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 2,
    :div_width => 320, :div_height => 200,
    :img_width => 320, :img_height => 200,
    :style => 'position:relative;top:0px;right:0px;')
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 3,
    :div_width => 630, :div_height => 110,
    :img_width => 120, :img_height => 100,
    :style => 'position:relative;float:left;top:0px;left:10px;right:10px ',
    :effect => Banner::E_MSLIDE);
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 4,
    :div_width => 650, :div_height => 130,
    :img_width => 210, :img_height => 120,
    :style => 'position:relative;float:left;top:0px;left:0px;')
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 5,
    :div_width => 650, :div_height => 130,
    :img_width => 210, :img_height => 120,
    :style => 'position:relative;float:left;top:0px;left:0px;')
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 6,
    :div_width => 650, :div_height => 160,
    :img_width => 210, :img_height => 150,
    :style => 'position:relative;float:right;top:0px;left:0px;')
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 7,
    :div_width => 650, :div_height => 160,
    :img_width => 210, :img_height => 150,
    :style => 'position:relative;float:right;top:0px;left:0px;')
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 8,
    :div_width => 650, :div_height => 160,
    :img_width => 210, :img_height => 150,
    :style => 'position:relative;float:right;top:0px;left:0px;')
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 9,
    :div_width => 650, :div_height => 160,
    :img_width => 210, :img_height => 150,
    :style => 'position:relative;float:right;top:0px;left:0px;')
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 10,
    :div_width => 650, :div_height => 160,
    :img_width => 210, :img_height => 150,
    :style => 'position:relative;float:right;top:0px;left:0px;')
    # Body
    [:p_signin,:p_signup].each do |page|
    Banner.create(:page_id => Style.pageid_key(page),
    :section_id => Style.sectionid(:s_body),
      :position_id => 1,
      :div_width => 220, :div_height => 130,
      :img_width => 220, :img_height => 130,
      :style => 'position:relative;float:left;top:0px',
      :is_disabled => true)
    end
    [:p_job,:p_buy_and_sell,:p_well_being,:p_study,:p_immig,:p_estate,:p_law,:p_tax,:p_yellowpage,:p_motor_vehicle,:p_business,:p_accommodation,:p_sponsor,:p_mypage].each do |page|
    Banner.create(:page_id => Style.pageid_key(page),
    :section_id => Style.sectionid(:s_body),
      :position_id => 1,
      :div_width => 220, :div_height => 130,
      :img_width => 220, :img_height => 130,
      :style => 'position:relative;float:left;top:0px')
    end
    [:p_signin,:p_signup,:p_signout, :p_job,:p_buy_and_sell,:p_well_being,:p_study,:p_immig,:p_estate,:p_law,:p_tax,:p_yellowpage,:p_motor_vehicle,:p_business,:p_accommodation,:p_sponsor,:p_mypage].each do |page|
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 2,
      :div_width => 220, :div_height => 150,
      :img_width => 220, :img_height => 150,
      :style => 'position:relative;float:left;top:0px')
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 3,
      :div_width => 220, :div_height => 150,
      :img_width => 220, :img_height => 150,
      :style => 'position:relative;float:left;top:0px')
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 4,
      :div_width => 220, :div_height => 150,
      :img_width => 220, :img_height => 150,
      :style => 'position:relative;float:left;top:0px')
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 5,
      :div_width => 740, :div_height => 150,
      :img_width => 740, :img_height => 150,
      :style => 'position:relative;float:left;top:0px')
    end
    # Buy and Sell Related
    [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_law,:p_tax,:p_study,:p_immig].each do |page|
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 6,
      :div_width => 240, :div_height => 150,
      :img_width => 240, :img_height => 150,
      :style => 'position:relative;float:left;top:0px')
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 7,
      :div_width => 240, :div_height => 150,
      :img_width => 240, :img_height => 150,
      :style => 'position:relative;float:left;top:0px;left:5px')
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 8,
      :div_width => 240, :div_height => 150,
      :img_width => 240, :img_height => 150,
      :style => 'position:relative;float:left;top:0px;left:10px')
    end
    # Signin
    [:p_signin].each do |page|
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 6,
      :div_width => 360, :div_height => 500,
      :img_width => 360, :img_height => 500,
      :style => 'position:relative;float:left;top:0px')
    end
    # Signout
    [:p_signout].each do |page|
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 6,
      :div_width => 500, :div_height => 600,
      :img_width => 500, :img_height => 600,
      :style => 'position:relative;float:left;top:0px')
    end
  end
  
end
