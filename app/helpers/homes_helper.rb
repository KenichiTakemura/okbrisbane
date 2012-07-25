module HomesHelper
  
  def generateTopFeed(category, lists, color)
    html = %Q|<div id="top_feed_list_#{category}"><div id="feed_head" style="background:#{color}"><div id="feed_head_left">#{t("#{category}")}</div><div id="feed_head_right"></div>|
    html += <<-HTML
       <div id="feed_head_menu">
       #{t('more')} | #{t('write_new')}</div>
    </div>
    <div id="feed_body">
    <table class="">
     <tr></tr>
    HTML
    if lists.nil? || lists.empty?
      html += %Q|<tr><td colspan="3"><p>#{t("no_information")}</p></td></tr>|
    else
      lists.each do |feed|
      html += <<-HTML
        <tr>
        <td><img src="assets/#{I18n.locale}/main/ic_arrow.gif"></td>
        <td nowrap class="small" height="18"><span title="#{feed.feeded_to.subject}">#{truncate(feed.feeded_to.subject, :length => 30)}</span></td>
        <td class="small_n" align="right">#{feed.feeded_to.postedDate}</td>
        </tr>
      HTML
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
