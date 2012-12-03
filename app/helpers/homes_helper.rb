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
    params = %Q|c: '#{category}'|
    post_script = _post(top_feed_homes_path, params)
    html = %Q|$('\#feed_body_#{category}').html("| + escape_javascript(image_tag("common/ajax_loading_1.gif")) + %Q|");|
    html += post_script
    html.html_safe
  end
  
  def top_feed_div(category)
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
  
  def generateTopFeed(category, lists, image_list)
    color = Okvalue::FEED_COLORMAP[category]
    html = %Q|<table class="table table-striped table-hover"><tr></tr>|
    if Style.text_feed?(category) && !lists.present?
      html += %Q|<tr><td colspan="4"><p>#{t("no_information")}</p></td></tr>|
    elsif Style.image_feed?(category) && !lists.present? && !image_list.present?
      html += %Q|<tr><td colspan="4"><p>#{t("no_information")}</p></td></tr>|
    else
      if image_list.present?
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

  def _navigation(over, out)
    html = ""
    Style::NAVI.each do |key|
      value = Style.page(key)
      if key.eql?(:p_yellowpage)
        link = yellowpage_okboards_path
      else
        link = Okboard.okboard_link(key)
      end
      html += %Q|<div class="btn-group"><button class="btn btn-primary">#{t(value)}</button>|
      html += %Q|<button class="btn dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button></div>|
      #html += %Q|<ul class="nav"><li><a href="#{link}" class="brand box_animation" id="navi_#{value}">#{t(value)}</a></li><li class="divider-vertical"></li></ul>|
    end
    html.strip.html_safe
  end
  
  def navigation
    script = ""
    html = %Q|<div class="navbar-wrapper"><div class="navbar"><div class="navbar-inner"><ul class="nav">|
    Style.navi.each do |key|
      value = Style.page(key)
      if key.eql?(:p_yellowpage)
        link = yellowpage_okboards_path
      else
        link = Okboard.okboard_link(key)
        #html += %Q|<li class="dropdown" id="navi_#{key}"><a href="#{link}" class="dropdown-toggle" data-toggle="" data-target="#">#{t(value)}<b class="caret"></b></a>|
        #html += %Q|<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel" id="popover_navi_#{key}">|
        #html += "<li><a href=\"#{link}\" tabindex=\"-1\">#{t(:latest_information)}</a></li>"
        #html += _sub_menu(key)
        #html += %Q|</ul>|
      end
      html += %Q|<li><a href="#{link}" id="navi_#{key}">#{t(value)}</a>|
      html += %Q|</li><li class="divider-vertical"></li>|
      script += %Q|
        $('\#navi_#{key}').mouseover(function(){$('\#popover_navi_#{key}').fadeIn()});
        $('\#navi_#{key}').mouseout(function(){$('\#popover_navi_#{key}').fadeOut()});|
      html += _script_document_ready(script)
    end
    html += "</ul></div></div></div>"
    html.strip.html_safe
  end
  
  def _sub_menu(link)
    logger.debug("_sub_menu @okpage: #{@okpage} link: #{link}")
    case link
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
    logger.debug("categories: #{categories}")
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
  
  def ___navigation(over, out)
    html = %Q|<div class="row-fluid navigation box_shadow box_round"><ul class="">|
    script = ""
    Style::NAVI.each do |key|
      if key.eql?(:p_yellowpage)
        link = yellowpage_okboards_path
      else
        link = Okboard.okboard_link(key)
      end
      value = Style.page(key)
      html += %Q|<li class="box_animation" id="navi_#{value}">#{t(value)}</li>|
      
      script += %Q|
        $('\#navi_#{value}').click(function(){window.location.href ="#{link}| + %Q|"});|
    end
    html += _script_document_ready(script)
    html += "</ul></div>"
    html.strip.html_safe
  end
  
  def __navigation(over, out)
    html = %Q|<div id="navigation"><ul class="navigation">|
    Style::NAVI.each do |key|
      if key.eql?(:p_yellowpage)
        link = yellowpage_okboards_path
      else
        link = Okboard.okboard_link(key)
      end
      value = Style.page(key)
      html += %Q|<li class="navi" id="navi_#{value}"><a href="""#{t(value)}</li>|
    end
    script = ""
    Style::NAVI.each do |key|
      value = Style.page(key)
      if key.eql?(:p_yellowpage)
        script += %Q|
        $('\#navi_#{value}').mouseover(function(){$(this).css("background-color","yellow")});
        $('\#navi_#{value}').mouseout(function(){$(this).css("background-color","")});
        $('\#navi_#{value}').click(function(){window.location.href ="#{yellowpage_okboards_path}| + %Q|"});|
      else
        script += %Q|
        $('\#navi_#{value}').mouseover(function(){$(this).css("background-color","#{Okvalue::COLORMAP[cycle("ok","naver","blue").to_sym]}"
        $('\#navi_#{value}').mouseout(function(){$(this).css("background-color","")});
        $('\#navi_#{value}').click(function() { window.location.href ="#{Okboard.okboard_link(key)}| + %Q|"});|
      end
    end
    html += _script_document_ready(script)
    html += "</ul></div>"
    html.strip.html_safe
  end


end
