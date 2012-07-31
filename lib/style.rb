module Style
    
  PAGES = Hash.new
  SECTIONS = Hash.new
  NAVI = Hash.new
  
  # div id rule is banner_#{page}_#{section}_#{position}
  
  PAGES[:p_home] = "p_home"
  PAGES[:p_signin] = "p_signin"
  PAGES[:p_signup] = "p_signup"
  PAGES[:p_job] = "p_job"
  PAGES[:p_buy_and_sell] = "p_buy_and_sell"
  PAGES[:p_wellbeing] = "p_wellbeing"
  PAGES[:p_study] = 'p_study'
  PAGES[:p_immig] = 'p_immig'
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


  def Style.create_banner_div(page, section, position)
    "banner_#{Style::PAGES[page]}_#{Style::SECTIONS[section]}_#{position}"
  end

end
