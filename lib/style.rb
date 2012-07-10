module Style
    
  PAGES = Hash.new
  SECTIONS = Hash.new
  ALIGNMENTS = Hash.new
  
  # div id rule is banner_#{page}_#{section}_#{alignment}
  
  PAGES[:home] = "home"
  PAGES[:signin] = "signin"
  PAGES[:signup] = "signup"
  PAGES[:job] = "job"
  PAGES[:buy_and_sell] = "buyandsell"
  
  SECTIONS[:header] = "header"
  SECTIONS[:background] = "background"
  SECTIONS[:main_content] = "main_content"
  SECTIONS[:secondary_content] = "secondary_content"
  SECTIONS[:third_content] = "third_content"
  SECTIONS[:fourth_content] = "fourth_content"
  SECTIONS[:fifth_content] = "fifth_content"
  SECTIONS[:side_bar] = "side_bar"

  ALIGNMENTS[:top_left] = "top_left"
  ALIGNMENTS[:top_right] = "top_right"
  ALIGNMENTS[:left] = "left"
  ALIGNMENTS[:right] = "right"
  ALIGNMENTS[:center] = "center"
  
  def Style.create_banner_div(page, section, align)
    "banner_" << Style::PAGES[page] << "_" << Style::SECTIONS[section] << "_" << Style::ALIGNMENTS[align]
  end

end
