# -*- coding: utf-8 -*-
module Style
    
  PAGES = Hash.new
  SECTIONS = Hash.new
  POSITION = Hash.new
  NAVI = Hash.new
  
  # div id rule is banner_#{page}_#{section}_#{position}
  
  PAGES[:home] = "p_home"
  PAGES[:signin] = "p_signin"
  PAGES[:signup] = "p_signup"
  PAGES[:job] = "p_job"
  PAGES[:buy_and_sell] = "p_buy_and_sell"
  
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
  SECTIONS[:main_content] = "s_main_content"
  SECTIONS[:secondary_content] = "s_secondary_content"
  SECTIONS[:third_content] = "s_third_content"
  SECTIONS[:fourth_content] = "s_fourth_content"
  SECTIONS[:fifth_content] = "s_fifth_content"
  SECTIONS[:side_bar] = "s_side_bar"

  POSITION[:north_west] = "a_north_west"
  POSITION[:north] = "a_north"
  POSITION[:north_east] = "a_north_east"
  POSITION[:west] = "a_west"
  POSITION[:center] = "a_center"
  POSITION[:east] = "a_east"
  POSITION[:south_west] = "a_south_west"
  POSITION[:south] = "a_south"
  POSITION[:south_east] = "a_south_east"
  
  def Style.create_banner_div(p, s, a)
    "banner_" << Style::PAGES[p] << "_" << Style::SECTIONS[s] << "_" << Style::POSITION[a]
  end

end
