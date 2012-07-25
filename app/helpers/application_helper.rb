module ApplicationHelper
  # Create banner
  def _collectImage(p, s, a)
    page = Page.find_by_name(Style::PAGES[p])
    section = Section.find_by_name(Style::SECTIONS[s])
    position = a
    b = Banner.where("page_id = ? AND section_id = ? AND position_id = ?", page, section, position).first
    raise "Bad Argument #{p} > #{s} > #{a}" if b.nil?
    logger.debug("banner: #{b}")
    images = b.client_image
    return b, images
  end
  
  
  
  def _banner(p, s, a, w, h)
    b,images = _collectImage(p,s,a)
    div_id = Style.create_banner_div(p,s,a)
    style = b.style
    logger.debug("div_id #{div_id} style: #{style}")
    html = %Q|<div id="#{div_id}" style="#{style}">|
    if images.empty?
      okbrisbane = BusinessClient.okbrisbane.first
      html += %Q|<div class="banner_description" id="banner_description_#{div_id}"><p class='description_content'>#{t('banner_contact')} #{okbrisbane.business_phone} #{okbrisbane.business_email}</p></div>|
      script = %Q|$('\##{div_id}').attr("style", "#{style} background:\#12345;width:#{w}px;height:#{h}px;border: 1px solid #c0c0c0;");|
      html += _script_document_ready(script)
    elsif
      images.each do |image|
        html += %Q|<img src="#{image.avatar.url(:original)}" width="#{b.width}px" height="#{b.height}px"/>|
      end
    end
    html += "</div>"
    return html.strip.html_safe
  end
  
  def single_banner(p, s, a)
    logger.debug("requested single_banner #{p}, #{s}, #{a}")
    b,images = _collectImage(p,s,a)
    html = _banner(p,s, a, b.width, b.height)
    logger.debug("html: #{html}")
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
    html = _banner(p,s, a, w, h)
    logger.debug("html: #{html}")
    html.strip.html_safe
  end
end
