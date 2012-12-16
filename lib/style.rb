module Style
  
  PAGES = Common.new_orderd_hash
  SECTIONS = Common.new_orderd_hash
  PAGE_IDS = Common.new_orderd_hash
  SECTION_IDS = Common.new_orderd_hash
  ADMIN_ROLES = Common.new_orderd_hash
  ALL_FEED = Common.new_orderd_hash
  TOPIC_FEED = Common.new_orderd_hash
  
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
  
  ADMIN_ROLES[:m_business_client] = "BusinessClientManagement"
  ADMIN_ROLES[:m_banner] = "BannerManagement"
  ADMIN_ROLES[:m_sales] = "SalesManagement"
  ADMIN_ROLES[:m_post] = "PostManagement"
  ADMIN_ROLES[:m_user] = "UserManagement"
  ADMIN_ROLES[:m_site] = "SiteStatistics"
  ADMIN_ROLES[:m_issue] = "IssueManagement"
  ADMIN_ROLES[:m_system_setting] = "SystemSettingManagement"
  
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

  PAGE_ID_MAX = 19
    
  SECTIONS[:s_header] = "s_header"
  SECTIONS[:s_background] = "s_background"
  SECTIONS[:s_body] = "s_body"

  SECTION_IDS[:s_header] = 1
  SECTION_IDS[:s_background] = 2
  SECTION_IDS[:s_body] = 3
  
  def self.pages
     PAGES
  end
  
  def self.admin_roles
    ADMIN_ROLES
  end
  
  def self.admin_role(o)
    admin_roles[o]
  end
  
  def self.banner_pages
    b_pages = pages.clone
    b_pages.delete(:p_issue)
    b_pages
  end
  
  def self.sections
    SECTIONS
  end

  def self.create_banner_div(page, section, position)
    #"banner_#{Style.page(page)}_#{Style.section(section)}_#{position}"
    suffix = Common.unique_token
    "banner_#{page}_#{Style.section(section)}_#{position}_#{suffix}"
  end

  def self.pageid_value(value)
    PAGE_IDS[PAGES.index value] 
  end
  
  def self.pageid_key(key)
    PAGE_IDS[key]
  end
  
  def self.pagename(id)
    return nil if id.nil?
    PAGES[PAGE_IDS.index id.to_i]
  end
  
  def self.pagename_sym(id)
    return nil if id.nil?
    PAGE_IDS.index id.to_i
  end
  
  def self.sectionid(key)
    SECTION_IDS[key]
  end
  
  def self.sectionname(id)
    return nil if id.nil?
    SECTIONS[SECTION_IDS.index id.to_i]
  end
  
  def self.sectionname_sym(id)
    return nil if id.nil?
    SECTION_IDS.index id.to_i
  end
  
  def self.page(key)
    Style::PAGES[key.to_sym]
  end
  
  def self.section(key)
    Style::SECTIONS[key.to_sym]
  end
  
  def self.m2s(model)
    PAGES.index model
  end
  
  ######  
  ALL_FEED[:p_job] = {:nav => true, :open => true, :feed => {:enabled => false, :image => false} }
  ALL_FEED[:p_buy_and_sell] = {:nav => true, :open => true, :feed => {:enabled => false, :image => false} }
  ALL_FEED[:p_well_being] = {:nav => true, :open => true, :feed => {:enabled => true, :image => true} }
  ALL_FEED[:p_estate] = {:nav => false, :open => false, :feed => {:enabled => false, :image => true} }
  ALL_FEED[:p_business] = {:nav => false, :open => false, :feed => {:enabled => false, :image => true} }
  ALL_FEED[:p_motor_vehicle] = {:nav => false, :open => false, :feed => {:enabled => false, :image => true} }
  ALL_FEED[:p_accommodation] = {:nav => true, :open => true, :feed => {:enabled => true, :image => true} }
  ALL_FEED[:p_study] = {:nav => true, :open => false, :feed => {:enabled => true, :image => false} }
  ALL_FEED[:p_immig] = {:nav => true, :open => false, :feed => {:enabled => false, :image => false} }
  ALL_FEED[:p_law] = {:nav => true, :open => false, :feed => {:enabled => true, :image => false} }
  ALL_FEED[:p_tax] = {:nav => true, :open => true, :feed => {:enabled => false, :image => false} }
  ALL_FEED[:p_yellowpage] = {:nav => false, :open => false, :feed => {:enabled => false, :image => false} }
  
  TOPIC_FEED[:p_buy_and_sell] = {:feed => {:enabled => true, :link => true, :text => page(:p_buy_and_sell)}}
  TOPIC_FEED[:p_job] = {:feed => {:enabled => true, :link => true, :text => page(:p_job)}}
  TOPIC_FEED[:p_most_viewed] = {:feed => {:enabled => true, :link => false, :text => "MostViewed"}}
  TOPIC_FEED[:p_most_commented] = {:feed => {:enabled => true, :link => false, :text => "MostCommented"}}
  TOPIC_FEED[:p_new_posted] = {:feed => {:enabled => true, :link => false, :text => "NewPosted"}}
  TOPIC_FEED[:p_new_images] = {:feed => {:enabled => true, :link => false, :text => "NewImages"}}
  
  def self.navi
    ALL_FEED.select { |k,v| v[:nav] }.collect { |k,v| k }
  end
  
  def self.topic_feed
    TOPIC_FEED.select { |k,v| v[:feed][:enabled]}
  end
  
  def self.topic_text?(page)
    TOPIC_FEED[page][:feed][:text]
  end
  
  def self.topic_linkable?(page)
    TOPIC_FEED[page][:feed][:link]
  end
  
  def self.open_page?(page)
    ALL_FEED[page][:open]
  end
  
  def self.text_feed?(page)
    if ALL_FEED[page]
      return !image_feed?(page)
    end
    false
  end
  
  def self.image_feed?(page)
    if ALL_FEED[page]
      return ALL_FEED[page][:feed][:image]
    end
    false
  end
  
  def self.feedable?(page)
    ALL_FEED[page][:feed][:enabled]
  end
  
  def self.feedable
    ALL_FEED.select { |k,v| v[:feed][:enabled]}
  end
  
  def self.text_feed
    feedable.select{ |k,v| !v[:feed][:image] }
  end
  
  def self.image_feed
    feedable.select{ |k,v| v[:feed][:image] }
  end
    
    
  Effect = Common.new_orderd_hash
  StyleClass = Common.new_orderd_hash
  
  # Rule page _ section _ postion
  # if _ section _ position => any page
  Effect[:any] = ""
  Effect[:_s_header_1] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},pagination:false,fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},autoHeight:false,generatePagination:false,hoverPause:true|
  Effect[:_s_header_2] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},pagination:false,fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},autoHeight:false,generatePagination:false,hoverPause:true|
  Effect[:Home_s_body_1] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},hoverPause:true,autoHeight:false,effect:'fade',crossfade:true,generateNextPrev:false|
  Effect[:Home_s_body_2] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},pagination:false,fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},autoHeight:false,generatePagination:false,hoverPause:true|
  Effect[:Home_s_body_3] = %Q|preload:true,pause:#{Okvalue::BANNER_EFFECT_PAUSE},fadeSpeed:#{Okvalue::BANNER_FADE_SPEED},hoverPause:true,autoHeight:false,autoHeightSpeed:1000,generatePagination:false,effect:'fade',crossfade:true,generateNextPrev:false|


  StyleClass[:any] = ""
  StyleClass[:Home_s_body_2] = ""

  def self.getEffect(page, section, position)
    key = "#{page}_#{section}_#{position}"
    effect = Effect[key.to_sym]
    return effect if effect.present?
    key = "_#{section}_#{position}"
    effect = Effect[key.to_sym]
    return effect if effect.present?
    key = "_#{position}"
    effect = Effect[key.to_sym]
    return effect if effect.present?
    Effect[:any]
  end
  
  def self.get_style_class(page, section, position)
    key = "#{page}_#{section}_#{position}"
    sc = StyleClass[key.to_sym]
    return sc if sc.present?
    key = "_#{section}_#{position}"
    sc = StyleClass[key.to_sym]
    return sc if sc.present?
    key = "_#{position}"
    sc = StyleClass[key.to_sym]
    return sc if sc.present?
    StyleClass[:any]
  end
  
  def self.create_banners
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
      :effect => Banner::E_FIX,
      :is_disabled => false)
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_header),
      :position_id => 2,
      :div_width => 710, :div_height => 120, :img_width => 710, :img_height => 120,
      :style => 'position:relative;float:right;right:0px',
      :effect => effect,
      :is_disabled => true)
      if value.eql? Style.page(:p_home)
        is_disabled = true
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
    :div_width => 650, :div_height => 410,
    :img_width => 650, :img_height => 380,
    :style => 'position:relative;float:left;top:0px',
    :effect => Banner::E_SLIDE);
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 2,
    :div_width => 320, :div_height => 220,
    :img_width => 320, :img_height => 200,
    :style => 'position:relative;top:0px;right:0px;',
    :effect => Banner::E_SLIDE);
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 3,
    :div_width => 530, :div_height => 110,
    :img_width => 120, :img_height => 100,
    :style => 'position:relative;float:left;top:0px;left:50px;padding:10px;',
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
    # New banner
    Banner.create(:page_id => Style.pageid_key(_page),
    :section_id => Style.sectionid(:s_body),
    :position_id => 11,
    :div_width => 650, :div_height => 130,
    :img_width => 210, :img_height => 120,
    :style => 'position:relative;float:left;top:0px;left:0px;')
    #
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
      if [:p_sponsor,:p_mypage,:p_yellowpage].include?(page)
        is_disabled = true
      else
        is_disabled = false
      end
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
        :position_id => 1,
        :div_width => 220, :div_height => 130,
        :img_width => 220, :img_height => 130,
        :style => 'position:relative;float:left;top:0px',
        :is_disabled => is_disabled)
      end
    [:p_signin,:p_signup,:p_signout, :p_job,:p_buy_and_sell,:p_well_being,:p_study,:p_immig,:p_estate,:p_law,:p_tax,:p_yellowpage,:p_motor_vehicle,:p_business,:p_accommodation,:p_sponsor,:p_mypage].each do |page|
      if [:p_sponsor,:p_mypage,:p_yellowpage].include?(page)
        is_disabled = true
      else
        is_disabled = false
      end
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 2,
      :div_width => 220, :div_height => 150,
      :img_width => 220, :img_height => 150,
      :style => 'position:relative;float:left;top:0px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 3,
      :div_width => 220, :div_height => 150,
      :img_width => 220, :img_height => 150,
      :style => 'position:relative;float:left;top:0px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 4,
      :div_width => 220, :div_height => 150,
      :img_width => 220, :img_height => 150,
      :style => 'position:relative;float:left;top:0px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 9,
      :div_width => 220, :div_height => 150,
      :img_width => 220, :img_height => 150,
      :style => 'position:relative;float:left;top:0px',
      :is_disabled => is_disabled)
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 5,
      :div_width => 740, :div_height => 150,
      :img_width => 740, :img_height => 150,
      :style => 'position:relative;float:left;top:0px',
      :is_disabled => is_disabled)
    end
    # Buy and Sell Related
    [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_law,:p_tax,:p_study,:p_immig].each do |page|
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 6,
      :div_width => 240, :div_height => 150,
      :img_width => 240, :img_height => 150,
      :style => 'position:relative;float:left;top:0px',
      :is_disabled => true)
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 7,
      :div_width => 240, :div_height => 150,
      :img_width => 240, :img_height => 150,
      :style => 'position:relative;float:left;top:0px;left:5px',
      :is_disabled => true)
      Banner.create(:page_id => Style.pageid_key(page),
      :section_id => Style.sectionid(:s_body),
      :position_id => 8,
      :div_width => 240, :div_height => 150,
      :img_width => 240, :img_height => 150,
      :style => 'position:relative;float:left;top:0px;left:10px',
      :is_disabled => true)
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
