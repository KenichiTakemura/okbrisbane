module ApplicationHelper
  # Create banner
  def _collectImage(p, s, a)
    page = Page.find_by_name(Style::PAGES[p])
    section = Section.find_by_name(Style::SECTIONS[s])
    position = Position.find_by_name(Style::POSITION[a])
    b = Banner.where("page_id = ? AND section_id = ? AND position_id = ?", page, section, position).first
    raise "Bad Argument #{p} > #{s} > #{a}" if b.nil?
    logger.debug("banner: #{b}")
    images = b.client_image
    return b, images
  end
  
  def single_banner(p, s, a)
    logger.debug("requested single_banner #{p}, #{s}, #{a}")
    # Collect all images for the banner space
    b,images = _collectImage(p,s,a)
    # When no images found
    # Create style
    # Create javascript
    # Generate HTML
    div_id = Style.create_banner_div(p,s,a)
    logger.debug("div_id #{div_id}")
    html = %Q|<div id="#{div_id}">|
    if images.empty?
      #html += %Q|<img src="assets/#{I18n.locale}/banner/noimage.jpg" width="#{b.width}px" height="#{b.height}px"/>|
      okbrisbane = BusinessClient.okbrisbane.first
      html += %Q|<div class="banner_description" id="banner_description_#{div_id}"><p class='description_content'>#{t('banner_contact')} #{okbrisbane.business_phone} #{okbrisbane.business_email}</p></div>|
      script = %Q|$('\##{div_id}').attr("style", "background:\#12345;width:#{b.width}px;height:#{b.height}px;border: 1px solid #c0c0c0;");|
      html += _script_document_ready(script)
    elsif
      images.each do |image|
        html += %Q|<img src="#{image.avatar.url(:original)}" width="#{b.width}px" height="#{b.height}px"/>|
      end
    end
    html += "</div>"
    # When more than two images found
    script = ""
    if images.size >= 2
      #script += %Q|$('\##{div_id}').cycle({fx: 'scrollRight',random: 1});|
      script += %Q|$('\##{div_id}').cycle({fx: 'fade',random: 1,timeout: 100});|
      
      html += _script_document_ready(script)
    end
    html.strip.html_safe
  end

  def navigation(over, out)
     logger.debug("navigation")
     html = %Q|<div id="navigation"><ul class="wat-cf">|
     Style::NAVI.each do |key, value|
      html += %Q|<li class="navi" id="navi_#{value}">#{t(value)}</li>|
     end
     script = ""
     Style::NAVI.each do |key, value|
      script += %Q|$('\#navi_#{value}').mouseover(function() { $(this).attr("style", "background: #{over}");}).mouseout(function(){$(this).attr("style", "background: #{out}");});|
     end
     html += _script_document_ready(script)
     html += "</ul></div>"
     html.strip.html_safe
  end
  
  def _script_document_ready(script)
    html = %Q|<script type="text/javascript" charset="utf-8">$(document).ready(function() {#{script}});</script>|
    html.html_safe
  end
  
  def _script
    %Q|<script type="text/javascript" charset="utf-8">|.html_safe
  end
  
  def multi_banner(p, s, a, w, h)
    logger.debug("requested multi_banner #{p}, #{s}, #{a}")
    b,images = _collectImage(p,s,a)
    div_id = Style.create_banner_div(p,s,a)
    logger.debug("div_id #{div_id}")
    html = %Q|<div id="#{div_id}">|
    if images.empty?
      #html += %Q|<img src="assets/#{I18n.locale}/banner/noimage.jpg" width="#{b.width}px" height="#{b.height}px"/>|
      okbrisbane = BusinessClient.okbrisbane.first
      html += %Q|<div class="banner_description" id="banner_description_#{div_id}"><p class='description_content'>#{t('banner_contact')} #{okbrisbane.business_phone} #{okbrisbane.business_email}</p></div>|
      script = %Q|$('\##{div_id}').attr("style", "background:\#12345;width:#{w}px;height:#{h}px;border: 1px solid #c0c0c0;");|
      html += _script_document_ready(script)
    elsif
      images.each do |image|
        html += %Q|<img src="#{image.avatar.url(:original)}" width="#{b.width}px" height="#{b.height}px" style="margin: 2px"/>|
      end
    end
    html += "</div>"
    # When more than two images found
    html.strip.html_safe
  end
end
