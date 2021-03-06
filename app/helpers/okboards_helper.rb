module OkboardsHelper
  def author_email(post)
    return "" if post.nil?
    logger.debug("posted_by: #{post.posted_by_type}")
    if post.posted_by_type.eql? "Admin"
      return SystemConfig.instance.admin_email
    else
    post.posted_by.email
    end
  end

  def section_span(post)
    section_span_for(post, @okpage)
  end

  def section_span_for(post, category, image_only=nil)
    html = %Q|<span ><ul class="thumbnails"><li><div class="thumbnail visible_span">|
    html += noimage?(post)
    if !post.image.empty?
      html += %Q|<div id="post_Carousel_#{post.id}" class="carousel slide"><div class="carousel-inner">|
      post.image.each_with_index do |image,index|
        if index == 0
          html += %Q|<div class="active item">| + image_tag(image.medium_image, :class => "img-polaroid") + "</div>"
        else
          html += %Q|<div class="item">| + image_tag(image.medium_image, :class => "img-polaroid") + "</div>"
        end
      end
      if post.image.size > 1
        html += %Q|<a class="carousel-control left" href="\#post_Carousel_#{post.id}" data-slide="prev">&lsaquo;</a>|
        html += %Q|<a class="carousel-control right" href="\#post_Carousel_#{post.id}" data-slide="next">&rsaquo;</a>|
      end
      html += "</div></div>"
      html += _script_document_ready(%Q|$('\#post_Carousel_#{post.id}').carousel();|)
    end
    if (image_only.present? && !image_only)
      html += %Q|<h3>| +  post.subject + "</h3>"
        if post.respond_to?(:price) && post.price.present?
          html += %Q|<p class="price_tag">| + post.price
          html += "</p>"
        end
      html += %Q|<p>|
      html += raw(post.content.body) if !post.content.nil?
      html += "</p>"
      html += link_to(image_tag("#{I18n.locale}/common/btn_info_view.gif"), Okboard.okboard_link_with_id(category, post.id))
    end
    html += "</div></li></ul></span>"
    html.html_safe
  end

  def build_board_list
    html = %Q|<table id="okboard_table" class="table table-striped table-hover">
        <thead class=""><tr><th style="width:0px;display:none"></th><th>#{t(:post_id)}</th><th>#{t("category")}</th><th>|
    if [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_buy_and_sell].include?(@okpage)
      html += t("price") + "</th><th>"
    end
    html += %Q|#{t("subject")}</th><th>#{t("created_at")}</th><th>#{t("viewed")}</th><th>#{t("comment")}</th>
    <th>#{t("author")}</th></tr></thead>|
    html += %Q|<tbody class="">|
    if @board_lists.empty?
      if [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_buy_and_sell].include?(@okpage)
        html += %Q|<tr><td colspan="9">| + t("no_information")
      else
        html += %Q|<tr><td colspan="8">| + t("no_information")
      end        
      html += "</td><tr>"
    else
      html += build_body_list_body
    end
    html += "</tbody></table>"
    html.html_safe
  end

  def build_body_list_body
    html = ""
    @board_lists.each do |post|
      html += %Q|<tr class="okboard_list_body #{cycle("odd", "even")}">|
      html += %Q|<td style="width:0px;display:none">#{post.id}</td>|
      html += %Q|<td><span class="badge">#{post.id}</span></td>|
      if post.is_admin_post_notice?
        html += %Q|<td><span class="badge badge-warning">#{t("#{post.category}")}</span></td>|
      else
        html += %Q|<td>#{t("#{post.category}")}</td>|
      end
      html += "<td>"
      if [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_buy_and_sell].include?(@okpage)
        html += "#{post.price}" + " </td><td>"
      end
      html += %Q|#{link_to_with_icon(_truncate_with_length(post.subject, Okvalue::OKBOARD_TRUNCATE_SIZE),Okboard.okboard_link_with_id(@okpage, post.id, (@post_search.nil? ? nil : @post_search.id)),"","","icon-play","")}</td><td>
       #{post.postedDate}</td><td>#{post.views}</td><td>|
       if post.comment.size > 0
         html += %Q|#{link_to(image_tag("#{I18n.locale}/common/say_1.jpg"),Okboard.okboard_link_with_id(@okpage, post.id, @post_search.id) + "#new_comment")}| + "#{post.comment.size}</td>"
       else
         html += %Q|<i class="icon-comment"></i>#{post.comment.size}</td>|
       end
      #if post.has_attachment?
      #  html += "<td>image_tag("common/IconData2.gif") + "#{post.attachment.size}" + </td>"
      #end
      html += %Q|<td >| + author_name(post) + %Q|</td>|
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
  
  def _left_side_menu
    html = %Q|<div id="page_section_left">|
    html += single_body_banner(1)
    #html += _left_side_menu_widget
    html += %Q|<div class="okboard_left_fixed_banners">|
    html += single_body_banner(2)
    html += single_body_banner(3)
    html += single_body_banner(4)
    html += single_body_banner(9)
    # scroll effect
    html += _scroll_banner_show("left_side_menu_banner_2", single_body_banner(2), Okvalue::LEFT_SIDE_MENU_BANNER_2_SHOW_SIZE)
    html += _scroll_banner_show("left_side_menu_banner_3", single_body_banner(3), Okvalue::LEFT_SIDE_MENU_BANNER_3_SHOW_SIZE)
    html += _scroll_banner_show("left_side_menu_banner_4", single_body_banner(4), Okvalue::LEFT_SIDE_MENU_BANNER_4_SHOW_SIZE)
    # 
    html += "</div></div>"
    html.html_safe
  end

  def _scroll_banner_show(id, banner, size)
    html = %Q|<div id="#{id}">#{banner}</div>|
    html += _script_document_ready(%Q|$(function() {
        var scroll_banner_#{id} = $('\##{id}'); 
        scroll_banner_#{id}.hide();
        $(window).scroll(function () {
        if ($(this).scrollTop() > #{size}) {
          scroll_banner_#{id}.fadeIn("slow");
        } else {
          scroll_banner_#{id}.fadeOut("slow");
        }
      });})|)
    html.html_safe
  end

  def _scroll_banner_hide_show(h_id, s_id, banner, size)
    html = %Q|<div id="#{s_id}">#{banner}</div>|
    html += _script_document_ready(%Q|$(function() {
        var scroll_banner_#{s_id} = $('\##{s_id}'); 
        var hide_banner_#{h_id} = $('\##{h_id}');
        scroll_banner_#{s_id}.hide();
        $(window).scroll(function () {
        if ($(this).scrollTop() > #{size}) {
          hide_banner_#{h_id}.fadeOut("slow");
          scroll_banner_#{s_id}.fadeIn("slow");
        } else {
          hide_banner_#{h_id}.fadeIn("slow");
          scroll_banner_#{s_id}.fadeOut("slow");
        }
      });})|)
    html.html_safe
  end


  def _left_side_menu_widget()
    html = %Q|<ul class="nav">|
    links = Okboard.get_links(@okpage)
    paths = _path(links)
    links.each_with_index do |link,i|
      html += %Q|<li class="dropdown">|
      html += %Q|<a href="#{paths[i]}" class="dropdown-toggle" data-toggle="dropdown" data-target="#"></i>#{t(Style.page(link))}<b class="caret"></b></a>|
      html += %Q|<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">|
      html += "<li><a href=\"#{paths[i]}\" tabindex=\"-1\">#{t(:latest_information)}</a></li>"
      html += _sub_menu(link)
      html += "</ul></li>"
    end
    html += "</ul>"
    html.html_safe
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
    return ""
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
  
  def show_filter
    html = ""
    if ![:p_mypage, :p_yellowpage].include?(@okpage)
      html += %Q|
      <div class="dropdown">
      <a href="#" class="dropdown-toggle btn btn-small" data-toggle="dropdown">
      <i class="icon-search icon-large"></i>#{t(:search)}<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li>
              #{render :partial => "okboards/shared/filter"}
            </li>
          </ul>
        </div>|
    end
    html.html_safe
  end
  
  def write_new_btn
    html = ""
    return html if !@okpage.present?
    if Style.open_page?(@okpage)
      html = link_to_with_icon(t(:write_new), Okboard.okboard_link_write(@okpage), "btn btn-small", "margin:1px", "icon-pencil","")
    end
    html.html_safe    
  end

end
