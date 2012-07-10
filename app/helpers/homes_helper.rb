module HomesHelper
  
  def generateTopFeed(category, lists)
    html = <<-HTML
    <div id="top_feed_list_#{category}">
    <div id="feed_head">
      <img src="assets/#{I18n.locale}/main/mtitle_#{category}.gif"/> <div id="feed_head_left"></div>
       <div id="feed_fead_more"><img src="assets/#{I18n.locale}/navi/bt_more.gif"/></div>
    </div>
    <div id="feed_body">
    <table class="">
      <tr></tr>
    HTML
      lists.each do |feed|
      html << <<-HTML
        <tr>
        <td><img src="assets/#{I18n.locale}/main/ic_arrow.gif"></td>
        <td nowrap class="small" height="18">#{feed.feeded_to.subject}</td>
        <td class="small_n" align="right">#{feed.feeded_to.postedDate}</td>
        </tr>
      HTML
      end
      html << <<-HTML
    </table>
    </div>
  </div>
  HTML


    html.html_safe
  end
  
end
