module HomesHelper
  
  def _bed_bath_garage(estate)
    html = image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_bed.gif") + " " + estate.bed.to_s + " " +
      image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_bath.gif") + " " + estate.bath.to_s + " " +
      image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_garage.gif") + " " + estate.garage.to_s 
  end
  
  def _scroll_feed(category, var_flag)
    html = %Q|if ($(this).scrollTop() > #{Okvalue::FEED_SHOW_SIZE[category]}) {
      if(!#{var_flag}) {
        #{_show_feed(category)}
        #{var_flag} = true;
      }
    }|
    html.html_safe
  end
  
  def _show_feed(category) 
    #[:p_job,:p_buy_and_sell,:p_estate,:p_business,:p_motor_vehicle,:p_accommodation,:p_law,:p_study]
    params = %Q|c: '#{category}'|
    post_script = _post(top_feed_homes_path, params)
    html = %Q|$('\#feed_body_#{category}').html("| + escape_javascript(image_tag("common/ajax_loading_1.gif")) + %Q|");|
    html += post_script
    html.html_safe
  end
  
  def top_feed_div(category, lists, image_list)
    color = Okvalue::FEED_COLORMAP[category]
    html = %Q|<div id="top_feed_list_#{category}" class="top_feed_list">|
    html += %Q|<div id="feed_head" style="position:relative;width:100%;height:40px;background:#{Okvalue::COLORMAP[color]}"><div id="feed_head_left"><p class="" style="line-height: 40px;">#{t("#{Style.page(category)}")}</p></div>|
    html += %Q|<div id="feed_head_right"><p>| + link_to(t('more'), Okboard.okboard_link(category), :class => "btn btn-small") + " "
    if [:p_job,:p_buy_and_sell,:p_well_being].include?(category)
      html += link_to(t('write_new'), Okboard.okboard_link_write(category), :class => "btn btn-small")
    end
    html += %Q|</p></div></div><div id="feed_body_#{category}" class="feed_body">|
    if !top_page_ajaxable?
      html += generateTopFeed(category, lists, image_list)
    end
    html += "</div></div>"
    html.html_safe
  end
  
  def generateTopFeed(category, lists, image_list)
    color = Okvalue::FEED_COLORMAP[category]
    html = %Q|<table class="table table-striped table-hover"><tr></tr>|
    if lists.nil? || (lists.empty? && image_list.nil?) || ((!lists.nil? && lists.empty?) && (!image_list.nil? && image_list.empty?))
      html += %Q|<tr><td colspan="4"><p>#{t("no_information")}</p></td></tr>|
    else
      if !image_list.nil? && !image_list.empty?
         image_list.each do |feed|
           html += %Q|<tr><td width=40%><div class="shadow">|
           image = feed.feeded_to.image_feed_for
           if image.linkable?
             html += "#{link_to(image_tag(image.thumb_image, :class => "image-resize140_120"), image.link_to_url)}</div></td>"
           else
             html += "#{image_tag(image.thumb_image, :class => "image-resize140_120")}</div></td>"
           end
           html += %Q|<td align="left" valign="top">#{_truncate_with_length(feed.feeded_to.subject, 70)}|
           html += "<p>#{feed.feeded_to.postedDate}</p>"
           if feed.feeded_to.respond_to? :price
             html += %Q|<p class="price_tag">| + feed.feeded_to.price + "</p>"
           end
           if category.eql?(:p_estate)
             html +=  %Q|<div class="bed_bath_garage">| + _bed_bath_garage(feed.feeded_to) + "</div>"
           else
             html += "<p></p>"
           end
           html += %Q|<div class="feed_category_view">| + link_to(t(:view),"#",:class => "btn btn-mini btn-info disabled") + section_span_for(feed.feeded_to,category) + "</div>"
        end
        html += %Q|</table><table class="table table-striped table-hover">|
      end      
      lists.each_with_index do |feed,index|
        html += %Q|<tr>|
        html += %Q|<td style="height:20px;"><img src="assets/#{I18n.locale}/#{Style.page(@okpage)}/ic_arrow.gif"></td>|
        html += %Q|<td>#{link_to(_truncate(feed.feeded_to.subject),Okboard.okboard_link_with_id(category, feed.feeded_to.id), :class => "btn-link small")}</td>|
        html += %Q|<td nowrap class="small">#{feed.feeded_to.feeded_date}</td></tr>|
      end
    end
    html += "</table>"
    html.html_safe
  end
  
end
