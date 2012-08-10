module HomesHelper
  
  def _bed_bath_garage(estate)
    html = image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_bed.gif") + " " + estate.bed.to_s + " " +
      image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_bath.gif") + " " + estate.bath.to_s + " " +
      image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_garage.gif") + " " + estate.garage.to_s 
  end
  
  def generateTopFeed(category, lists, image_list, color)
    html = %Q|<div id="top_feed_list_#{category}"><div id="feed_head" style="position:relative;width:300px;height:40px;background:#{Okvalue::COLORMAP[color]}"><div id="feed_head_left"><p class="" style="line-height: 40px;">#{t("#{category}")}</p></div>|
    html += %Q|<div id="feed_head_right"><p style="line-height: 25px;">| + link_to(t('more'), _okboard_link(category), :class => "button-link_#{color.to_s}") + " "
    html += link_to(t('write_new'), _okboard_link_write(category), :class => "button-link_#{color.to_s}")
    html += %Q|</p></div></div>|
    html += %Q|<div id="feed_body"><table class="" width=100%><tr></tr>|
    if lists.nil? || lists.empty?
      html += %Q|<tr><td colspan="4"><p>#{t("no_information")}</p></td></tr>|
    else
      if !image_list.nil? && !image_list.empty?
         image_list.each do |feed|
           html += %Q|<tr><td width=40%><div class="shadow">#{image_tag(feed.feeded_to.image.first.avatar.url(:thumb), :size => Okvalue::TOPFEED_IMAGE_SIZE)}</div></td>
           <td align=left valign=top>#{_truncate_with_length(feed.feeded_to.subject, 70)}|
           if feed.feeded_to.respond_to? :price
             html += %Q|<p class="price_tag">| + _price(feed.feeded_to.price)
             if category.eql? Style.page(:p_motor_vehicle)
               html += %Q|<br/>#{t("drive_away")}|
             elsif category.eql? Style.page(:p_business)
               html += %Q|<br/>Brisbane CBD|
             end
             html += "</p>"
           end
           if category.eql? Style.page(:p_estate)
             html +=  %Q|<div class="bed_bath_garage">| + _bed_bath_garage(feed.feeded_to) + "</div>"
           else
             html += "<p></p>"
           end
           html += %Q|<div class="feed_category_view">| + t("view") + section_span_for(feed.feeded_to,category) + "</div>"
           
        end
        html += %Q|</table><table class="">|
      end      
      lists.each_with_index do |feed,index|
        html += %Q|<tr height="20px">|
        html += %Q|<td><img src="assets/#{I18n.locale}/#{@okpage}/ic_arrow.gif"></td>|
        html += %Q|<td nowrap class="small" height="18" width=60%>#{_truncate(feed.feeded_to.subject)}</td>|
        html += %Q|<td class="small_n">#{feed.feeded_to.postedDate}</td>|
        html += %Q|<td width="20%" align=right>| + link_to(t("view"), _okboard_link_with_id(category.to_sym, feed.feeded_to.id), :class => "button-link_#{color.to_s}") +  "</td></tr>"
      end
    end
    html += <<-HTML
    </table>
    </div>
    </div>
    HTML
    html.strip!.html_safe
  end
  
end
