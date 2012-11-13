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
    html = %Q|<div id="top_feed_list_#{category}" class="top_feed_list box_round box_shadow white_box">|
    html += %Q|<div id="feed_head" style="position:relative;width:100%;height:40px;background:#{Okvalue::COLORMAP[color]}"><div class="box_round box_shadow box_textshadow" id="feed_head_left"><p class="" style="line-height: 40px;">#{t("#{Style.page(category)}")}</p></div>|
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
  
  def navigation(over, out)
    html = %Q|<div class="row navigation box_bgsize"><ul class="">|
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
