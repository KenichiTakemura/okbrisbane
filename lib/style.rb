module Style
    
  PAGES = Hash.new
  SECTIONS = Hash.new
  NAVI = Hash.new
  
  # div id rule is banner_#{page}_#{section}_#{position}
  
  PAGES[:home] = "p_home"
  PAGES[:signin] = "p_signin"
  PAGES[:signup] = "p_signup"
  PAGES[:job] = "p_job"
  PAGES[:buy_and_sell] = "p_buy_and_sell"
  PAGES[:lifeinfo] = "p_lifeinfo"
  PAGES[:p_study] = 'p_study'
  PAGES[:p_immig] = 'p_immig'
  PAGES[:p_estate] = 'p_estate'
  PAGES[:p_living] = 'p_living'
  PAGES[:p_law] = 'p_law'
  PAGES[:p_yellowpage] = 'p_yellowpage'
  PAGES[:sponsor] = "p_sponsor"

  
  NAVI[:job] = "p_job"
  NAVI[:p_buy_and_sell] = "p_buy_and_sell"
  NAVI[:p_info] = "p_lifeinfo"
  NAVI[:p_study] = "p_study"
  NAVI[:p_immig] = "p_immig"
  NAVI[:p_estate] = "p_estate"
  NAVI[:p_living] = "p_living"
  NAVI[:p_law] = "p_law"
  NAVI[:p_yellowpage] = "p_yellowpage"
  
  SECTIONS[:header] = "s_header"
  SECTIONS[:background] = "s_background"
  SECTIONS[:body] = "s_body"
  #SECTIONS[:main_content] = "s_main_content"
  #SECTIONS[:secondary_content] = "s_secondary_content"
  #SECTIONS[:third_content] = "s_third_content"
  #SECTIONS[:fourth_content] = "s_fourth_content"
  #SECTIONS[:fifth_content] = "s_fifth_content"
  #SECTIONS[:side_bar] = "s_side_bar"

  def Style.create_banner_div(page, section, position)
    "banner_#{Style::PAGES[page]}_#{Style::SECTIONS[section]}_#{position}"
  end

end
