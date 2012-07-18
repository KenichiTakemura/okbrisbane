module ApplicationHelper
  # Create banner
  def banner(p, s, a)
    logger.debug("requested banner: #{p}, #{s}, #{a}")
    # Collect all images for the banner space
    page = Page.find_by_name(Style::PAGES[p])
    section = Section.find_by_name(Style::SECTIONS[s])
    alignment = Alignment.find_by_name(Style::ALIGNMENTS[a])
    b = Banner.where("page_id = ? AND section_id = ? AND alignment_id = ?", page, section, alignment).first
    logger.debug("banner: #{b}")
    images = b.client_image
    # When no images found
    # Create style
    # Create javascript
    # Generate HTML

    div_id = Style.create_banner_div(p,s,a)
    logger.debug("div_id #{div_id}")
    html = %Q|<div id="#{div_id}">|
    if images.empty?
      html += %Q|<img src="assets/#{I18n.locale}/banner/noimage.jpg" width="#{b.width}px" height="#{b.height}px"/>|
    elsif
      images.each do |image|
        html += %Q|<img src="#{image.avatar.url(:original)}" width="#{b.width}px" height="#{b.height}px"/>|
      end
    end
    html += "</div>"
    # When more than two images found
    if images.size >= 2
      html += %Q|<script type="text/javascript" charset="utf-8">$(document).ready(function() {|
      html += %Q|$('\##{div_id}').cycle({fx: 'scrollRight',random: 1});});</script>|
    end
    html.strip.html_safe
  end

end
