module OkboardsHelper
  
  def author_name(post)
    return "" if post.nil?
    logger.debug("posted_by: #{post.posted_by_type}")
    if post.posted_by_type.eql? "Admin"
      return t('admin')
    end
  end
  
  def section_span(post)
    logger.debug("section_span post: #{post.id}")
    html = "<span><section>"
    html += image_tag(post.image.first.avatar.url(:medium))
    html += %Q|<p class="okboard_subject">| +  post.subject
    html += %Q|</p><p class="price_tag">$ | + post.price.to_s
    html += "<br/>" + t("drive_away")
    html += %Q|</p><p class="description">|
    html += raw(post.content.body)
    html += "</p>"
    html += link_to(t("more"), _okboard_link(Style::PAGES[@okpage]) << "&bd=#{post.id}")
    html += "</section></span>" 
    html.html_safe
  end
  
end
