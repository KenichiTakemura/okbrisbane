module HomesHelper
  
  def generateTopFeed(category, lists, image_list, color)
    html = %Q|<div id="top_feed_list_#{category}"><div id="feed_head" style="position:relative;width:300px;height:40px;background:#{color}"><div id="feed_head_left"><p class="" style="line-height: 40px;">#{t("#{category}")}</p></div>|
    html += %Q|<div id="feed_head_right"><p style="line-height: 30px;">#{t('more')} \| #{t('write_new')}</p></div></div>|
    html += %Q|<div id="feed_body"><table class=""><tr></tr>|
    if lists.nil? || lists.empty?
      html += %Q|<tr><td colspan="3"><p>#{t("no_information")}</p></td></tr>|
    else
      if !image_list.nil? && !image_list.empty?
         image_list.each do |feed|
           html += %Q|<tr><td><div class="shadow">#{image_tag(feed.feeded_to.image.first.avatar.url(:thumb), :size => "120x90")}</div></td><td align=left valign=top>#{_truncate_with_length(feed.feeded_to.subject, 70)}<p class="price_tag">$&nbsp;#{_price(feed.feeded_to.price)}</p></td></tr>|
        end
        html += %Q|</table><table class="">|
      end      
      lists.each_with_index do |feed,index|
        html += "<tr>"
        html += %Q|<td><img src="assets/#{I18n.locale}/main/ic_arrow.gif"></td>|
        html += %Q|<td nowrap class="small" height="18" width=80%>#{_truncate(feed.feeded_to.subject)}</td>|
        html += %Q|<td class="small_n" width=20%>#{feed.feeded_to.postedDate}</td></tr>|
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
