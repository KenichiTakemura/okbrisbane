module HomesHelper
  
  def generateTopFeed(category, lists, image_list, color)
    html = %Q|<div id="top_feed_list_#{category}"><div id="feed_head" style="position:relative;width:300px;height:40px;background:#{color}"><div id="feed_head_left"><p class="" style="line-height: 40px;">#{t("#{category}")}</p></div>|
    html += %Q|<div id="feed_head_right"><p style="line-height: 30px;">| + link_to(t('more'), _okboard_link(category)) + " | "
    if current_user
      html += link_to(t('write_new'), "#")
    else
      html += link_to(t('write_new'), user_sign_in_path)
    end
    
    html += %Q|</p></div></div>|
    html += %Q|<div id="feed_body"><table class=""><tr></tr>|
    if lists.nil? || lists.empty?
      html += %Q|<tr><td colspan="4"><p>#{t("no_information")}</p></td></tr>|
    else
      if !image_list.nil? && !image_list.empty?
         image_list.each do |feed|
           html += %Q|<tr><td><div class="shadow">#{image_tag(feed.feeded_to.image.first.avatar.url(:thumb), :size => Okvalue::TOPFEED_IMAGE_SIZE)}</div></td>
           <td align=left valign=top>#{_truncate_with_length(feed.feeded_to.subject, 70)}
           <p class="price_tag">| + _price(feed.feeded_to.price)
           if category.eql? Style::PAGES[:p_motor_vehicle]
             html += %Q|<br/>#{t("drive_away")}|
           end
           html += %Q|</p><div class="okboard_feed_thumbnail_view">| + link_to(t("view"), _okboard_link(category.to_sym) << "&bd=#{feed.feeded_to.id}") +  "</div></td></tr>"
        end
        html += %Q|</table><table class="">|
      end      
      lists.each_with_index do |feed,index|
        html += "<tr>"
        html += %Q|<td><img src="assets/#{I18n.locale}/#{@okpage}/ic_arrow.gif"></td>|
        html += %Q|<td nowrap class="small" height="18" width=60%>#{_truncate(feed.feeded_to.subject)}</td>|
        html += %Q|<td class="small_n">#{feed.feeded_to.postedDate}</td>|
        html += %Q|<td width="20%"><div class="okboard_feed_thumbnail_view">| + link_to(t("view"), _okboard_link(category.to_sym) << "&bd=#{feed.feeded_to.id}") +  "</div></td></tr>"
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
