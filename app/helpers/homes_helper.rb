module HomesHelper
  
  def _bed_bath_garage(estate)
    html = image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_bed.gif") + " " + estate.bed.to_s + " " +
      image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_bath.gif") + " " + estate.bath.to_s + " " +
      image_tag("#{I18n.locale}/#{Style.page(:p_estate)}/icon_garage.gif") + " " + estate.garage.to_s 
  end
  
  def _scroll_feed(category, var_flag)
    return "" if !Style.feedable?(category)
    html = %Q|if ($(this).scrollTop() > #{Okvalue::FEED_SHOW_SIZE[category]}) {
      if(!#{var_flag}) {
        #{_show_feed(category)}
        #{var_flag} = true;
      }
    }|
    html.html_safe
  end

  def _show_feed(category) 
    params = %Q|c: '#{category}'|
    post_script = Ajax.post(top_feed_homes_path, params)
    html = %Q|$('\#feed_body_' + '#{category}').html("| + escape_javascript(image_tag("common/ajax_loading_1.gif")) + %Q|");|
    html += post_script
    html.html_safe
  end
  
  def topic_feed_div(category, id)
    html = %Q|<div class="row-fluid"><div class="btn-toolbar">|
    if Style.topic_linkable?(category)
      html += %Q|<div class="btn-group">| + link_to(t('more'), Okboard.okboard_link(category), :class => "btn btn-small") + "</div>"
      if Style.open_page?(category)
        html += %Q|<div class="btn-group"><a href="#{Okboard.okboard_link_write(category)}" class="btn btn-small"><i class="icon-pencil"></i>#{t(:write_new)}</a></div>|
      end
      sub_categories(category).each do |key,sub_category|
        html += %Q|<div class="btn-group"><a href="#{Okboard.okboard_link_with_category(category,sub_category)}" class="btn btn-link" >#{t(sub_category)}</a></div>|
      end
    end
    html += %Q|</div><div class="row-fluid" id="#{id}"></div></div>|
    html.html_safe
  end
  
  def top_feed_div(category)
    return if !Style.feedable?(category)
    color = Okvalue::FEED_COLORMAP[category]
    lists = @feed_lists[category]
    image_list = @image_feed_lists[category]
    html = %Q|<div id="top_feed_list_#{category}" class="top_feed_list box_round white_box bs-docs">|
    html += %Q|<div id="feed_head" style="position:relative;width:100%;height:40px;background:#{Okvalue::COLORMAP[color]}"><div class="box_round" id="feed_head_left"><p class="" style="line-height: 40px;">#{t("#{Style.page(category)}")}</p></div>|
    html += %Q|<div id="feed_head_right"><p>| + link_to(t('more'), Okboard.okboard_link(category), :class => "btn btn-small") + " "
    if Style.open_page?(category)
      html += %Q|<a href="#{Okboard.okboard_link_write(category)}" class="btn btn-small"><i class="icon-pencil"></i>#{t(:write_new)}</a>|
    end
    html += %Q|</p></div></div><div id="feed_body_#{category}" class="feed_body">|
    if !top_page_ajaxable? || Okvalue::FEED_SHOW_SIZE[category] < 1
      html += generateTopFeed(category, lists, image_list)
    end
    html += "</div></div>"
    html.html_safe
  end
  
  def generateTopFeed(category, lists, image_list, length=nil, author=nil, views=nil, comment=nil)
    html = ""
    if Style.text_feed?(category) && !lists.present?
      html += %Q|<p>#{t("no_information")}</p>|
    elsif Style.image_feed?(category) && !lists.present? && !image_list.present?
      html += %Q|<p>#{t("no_information")}</p>|
    elsif !lists.present? && !image_list.present?
      html += %Q|<p>#{t("no_information")}</p>|
    else
      html = %Q|<table class="table table-hover table-condensed"><tr></tr>|
      if image_list.present?
         image_list.each do |feed|
           category = Style.m2s(feed.feeded_to_type)
           html += %Q|<tr><td width=40%><div class="shadow">|
           image = feed.feeded_to.image_feed_for
           if image.linkable?
             html += "#{link_to(image_tag(image.thumb_image, :class => "image-resize140_120"), image.link_to_url)}</div></td>"
           else
             html += "#{image_tag(image.thumb_image, :class => "image-resize140_120")}</div></td>"
           end
           html += %Q|<td align="left" valign="top">#{_truncate_with_length(feed.feeded_to.subject, 70)}|
           html += "<p>#{feed.feeded_to.postedDate}</p>"
           if feed.feeded_to.respond_to?(:price) && feed.feeded_to.price.present?
             html += %Q|<p class="price_tag">| + feed.feeded_to.price + "</p>"
           end
           if category.eql?(:p_estate)
             html +=  %Q|<div class="bed_bath_garage">| + _bed_bath_garage(feed.feeded_to) + "</div>"
           else
             html += "<p></p>"
           end
           html += %Q|<div class="feed_category_view">| + link_to(t(:view),"#",:class => "btn btn-mini btn-info disabled") + section_span_for(feed.feeded_to,category) + "</div>"
        end
        html += %Q|</table><table class="table table-striped table-hover table-condensed">|
      end
      lists.each_with_index do |feed,index|
        post = feed.respond_to?(:feeded_to)? feed.feeded_to : feed.hot_feeded_to
        Rails.logger.debug("feedpost: #{post}")
        category = Style.m2s(post.class.to_s)
        html += %Q|<tr>|
        html += %Q|<td style="height:20px;"><img src="assets/#{I18n.locale}/#{Style.page(@okpage)}/ic_arrow.gif"></td>|
        html += %Q|<td>#{link_to(_truncate_with_length(post.subject,length), Okboard.okboard_link_with_id(category, post.id), :class => "btn-link")}</td>|
        html += %Q|<td nowrap>#{t(post.category)}</td>|
        if author.present? && author
          html += %Q|<td><i class="icon-user"></i>&nbsp;#{author_name(post)}</td>|
        end
        html += %Q|<td nowrap>#{post.feeded_date}</td>|
        if views.present? && views
          html += %Q|<td>#{post.views}</td>|
        end
        if comment.present? && comment
          html += %Q|<td><i class="icon-comment"></i>&nbsp;#{post.comment.size}</td></tr>|
          html += %Q|<tr><td colspan="6"><blockquote><span class="topic-inline-comment">#{post.comment.last.body}</span><small><i class="icon-user"></i>&nbsp;#{comment_author(post.comment.last)}&nbsp;#{post.comment.last.feeded_date} </small></blockquote></td>|
        end
        html += "</tr>"
      end
      html += "</table>"
    end
   
    html.html_safe
  end
  
  def sub_categories(category)
    case category
    when :p_job
      categories = Job::Categories
    when :p_buy_and_sell
      categories = BuyAndSell::Categories
    when :p_well_being
      categories = WellBeing::Categories
    when :p_motor_vehicle
      categories = MotorVehicle::Categories
    when :p_estate
      categories = Estate::Categories
    when :p_business
      categories = Business::Categories
    when :p_accommodation
      categories = Accommodation::Categories
    when :p_law
      categories = Law::Categories
    when :p_tax
      categories = Tax::Categories
    when :p_study
      categories = Study::Categories
    when :p_immig
      categories = Immigration::Categories
    else
      raise Exceptions::BadRequestError
    end
    categories
  end
  
  def _sub_menu(link)
    categories = sub_categories(link)
    html = ""
    categories.each do |key,category|
      html += "<li><a href=\"#{Okboard.okboard_link_with_category(link,category)}\" tabindex=\"-1\">#{t(category)}</a></li>"
    end
    if Style.open_page?(link)
      html += "<li><a href=\"#{Okboard.okboard_link_write(link)}\" tabindex=\"-1\">#{t(:write_new)}</a></li>"
    end
    html.html_safe
  end
  
  
  def _path(links)
    path = Array.new
    links.each do |link|
      if link.eql?(:p_yellowpage)
        path.push(yellowpage_okboards_path)
      else
        path.push(Okboard.okboard_link(link))
      end
    end
    path
  end


end
