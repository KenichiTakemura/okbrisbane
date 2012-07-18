# -*- coding: utf-8 -*-
module Style
    
  PAGES = Hash.new
  SECTIONS = Hash.new
  ALIGNMENTS = Hash.new
  
  # div id rule is banner_#{page}_#{section}_#{alignment}
  
  PAGES[:home] = "p_home"
  PAGES[:signin] = "p_signin"
  PAGES[:signup] = "p_signup"
  PAGES[:job] = "p_job"
  PAGES[:buy_and_sell] = "p_buy_and_sell"
  
  SECTIONS[:header] = "s_header"
  SECTIONS[:background] = "s_background"
  SECTIONS[:main_content] = "s_main_content"
  SECTIONS[:secondary_content] = "s_secondary_content"
  SECTIONS[:third_content] = "s_third_content"
  SECTIONS[:fourth_content] = "s_fourth_content"
  SECTIONS[:fifth_content] = "s_fifth_content"
  SECTIONS[:side_bar] = "s_side_bar"

  ALIGNMENTS[:top_left] = "a_top_left"
  ALIGNMENTS[:top_right] = "a_top_right"
  ALIGNMENTS[:left] = "a_left"
  ALIGNMENTS[:right] = "a_right"
  ALIGNMENTS[:center] = "a_center"
  
  def Style.create_banner_div(p, s, a)
    "banner_" << Style::PAGES[p] << "_" << Style::SECTIONS[s] << "_" << Style::ALIGNMENTS[a]
  end

end
