module OkboardsHelper
  
  def author_name(post)
    return "" if post.nil?
    logger.debug("posted_by: #{post.posted_by_type}")
    if post.posted_by_type.eql? "Admin"
      return t('admin')
    else
      post.posted_by.email
    end
  end
  
  def author_email(post)
    return "" if post.nil?
    logger.debug("posted_by: #{post.posted_by_type}")
    if post.posted_by_type.eql? "Admin"
      return Okvalue::ADMIN_EMAIL
    else
      post.posted_by.email
    end
  end
  
  def section_span(post)
    logger.debug("section_span post: #{post.id}")
    html = "<span><section>"
    html += noimage?(post)
    html += image_tag(post.image.first.avatar.url(:medium)) if !post.image.empty?
    html += %Q|<p class="okboard_subject">| +  post.subject
    html += %Q|</p><p class="price_tag">| + number_to_currency(post.price, :locale => 'en')
    if @okpage.to_s.eql? Style::PAGES[:p_motor_vehicle]
      html += "<br/>" + t("drive_away")
    end
    html += %Q|</p><p class="description">|
    html += raw(post.content.body) if !post.content.nil?
    html += "</p>"
    html += link_to(t("more"), _okboard_link(Style::PAGES[@okpage]) << "&bd=#{post.id}") + " | "
    html += mail_to(author_email(post), t("contact_person"), :encode => "hex")
    html += "</section></span>" 
    html.html_safe
  end
  
  def build_board_list()
    html = ""
    if @board_lists.empty?
      html = html += %Q|<div id="okboard_list_body">| + t("no_information")
      html += "</div>"
    else
      @board_lists.each do |post|
        html += %Q|<div id="okboard_list_body"><ul class="okboard_list_body"><li class="first">|
        html += t("#{post.category}")
        html += %Q|</li><li class="normal">|
        html += number_to_currency(post.price, :locale => 'en')
        html += %Q|</li><li class="normal">|
        html += _truncate_no_title(post.subject)
        html += %Q|</li><li class="normal">|
        html += Common.date_format(post.updated_at)
        html += %Q|</li><li class="last">|
        html += post.views.to_s
        html += "</li></ul>"
        html += section_span(post)
        html += "</div>"
      end
    end
    html.html_safe
  end
  
end
