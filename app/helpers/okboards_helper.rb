module OkboardsHelper
  def author_email(post)
    return "" if post.nil?
    logger.debug("posted_by: #{post.posted_by_type}")
    if post.posted_by_type.eql? "Admin"
      return SystemSetting.first.admin_email
    else
    post.posted_by.email
    end
  end

  def section_span(post)
    section_span_for(post, @okpage)
  end

  def section_span_for(post, category)
    html = %Q|<span style="background-color: #e0e0e0;><ul class="thumbnails"><li><div class="thumbnail">|
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
    html += %Q|<h3>| +  post.subject + "</h3>"
    if post.respond_to?(:price)
      html += %Q|<p class="price_tag">| + post.price
      html += "</p>"
    end
    html += %Q|<p>|
    html += raw(post.content.body) if !post.content.nil?
    html += "</p>"
    html += link_to(image_tag("#{I18n.locale}/common/btn_info_view.gif"), Okboard.okboard_link_with_id(category, post.id))
    html += "</div></li></ul></span>"
    html.html_safe
  end

  def build_board_list
    html = %Q|<table id="okboard_table" class="table table-striped table-hover">
        <thead class=""><tr><th>#{t("category")}</th><th>|
    if [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_buy_and_sell].include?(@okpage)
      html += t("price") + "</th><th>"
    end
    html += %Q|#{t("subject")}</th><th>#{t("created_at")}</th><th>#{t("viewed")}</th><th>#{t("comment")}</th>
    <th>#{t("image")}</th><th>#{t("attachment")}</th><th>#{t("author")}</th></tr></thead>|
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
      if post.category.eql?(Okvalue::ADMIN_POST_NOTICE)
        html += %Q|<td width=15% style="color:red">#{t("#{post.category}")}</td>|
      else
        html += %Q|<td width=15%>#{t("#{post.category}")}</td>|
      end
      html += "<td>"
      if [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_buy_and_sell].include?(@okpage)
        html += "#{post.price}" + " </td><td>"
      end
      html += %Q|#{link_to_with_icon(_truncate_with_length(post.subject, 35),Okboard.okboard_link_with_id(@okpage, post.id, (@post_search.nil? ? nil : @post_search.id)),"","","icon-play")}</td><td>
       #{post.postedDate}</td><td>#{post.views}</td><td>|
       if post.comment.size > 0
         html += %Q|#{link_to(image_tag("#{I18n.locale}/common/say_1.jpg"),Okboard.okboard_link_with_id(@okpage, post.id, @post_search.id) + "#new_comment")}| + "#{post.comment.size}</td><td>"
       else
         html += %Q|#{image_tag("#{I18n.locale}/common/say.png")}| + "#{post.comment.size}</td><td>"
       end
      if post.has_image?
        html += image_tag("common/IconData2.gif") + post.image.size.to_s
      end
      html += "</td><td>"
      if post.has_attachment?
        html += image_tag("common/IconData2.gif")
      end
      html += %Q|</td><td >| + author_name(post) + %Q|</td>|
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
    #html += widget("left_side_menu",220,nil,_left_side_menu_widget,"affix")
    html += _left_side_menu_widget
    html += %Q|<div class="okboard_left_fixed_banners">|
    html += single_body_banner(2)
    html += single_body_banner(3)
    html += single_body_banner(4)
    html += "</div></div>"
    html.html_safe
  end

  def _left_side_menu_widget()
    html = %Q|<div class="dropdown"><ul class="nav nav-pills nav-stacked affix" style="bottom:150px;left:100px;">|
    case @okpage
    when :p_job
      links = [:p_job,:p_buy_and_sell,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    when :p_buy_and_sell
      links = [:p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    when :p_well_being
      links = [:p_well_being,:p_job,:p_buy_and_sell,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    when :p_estate
      links = [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    when :p_motor_vehicle
      links = [:p_motor_vehicle,:p_estate,:p_business,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    when :p_business
      links = [:p_business,:p_estate,:p_motor_vehicle,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    when :p_accommodation
      links = [:p_accommodation,:p_estate,:p_motor_vehicle,:p_business,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    when :p_law
      links = [:p_law,:p_tax,:p_study,:p_immig,:p_mypage,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
      paths = _path(links)
    when :p_tax
      links = [:p_tax,:p_law,:p_study,:p_immig,:p_mypage,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
      paths = _path(links)
    when :p_study
      links = [:p_study,:p_law,:p_tax,:p_immig,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
      paths = _path(links)
    when :p_immig
      links = [:p_immig,:p_law,:p_tax,:p_study,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
      paths = _path(links)
    when :p_yellowpage
      links = [:p_yellowpage,:p_law,:p_tax,:p_study,:p_immig,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
      paths = _path(links)
    when :p_mypage
      links = [:p_job,:p_buy_and_sell,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    when :p_sponsor
      links = [:p_job,:p_buy_and_sell,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig]
      paths = _path(links)
    else
      raise "Not implemented"
    end
    links.each_with_index do |link,i|
      html += %Q|<li style="position:relative">|
      html += %Q|<a href="#{paths[i]}" class="btn dropdown-toggle" data-toggle="dropdown" data-target="#"></i>#{t(Style.page(link))}<b class="caret"></b></a>|
      html += %Q|<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel" style="position:absolute;left:100px;">|
      html += "<li><a href=\"#{paths[i]}\" tabindex=\"-1\">#{t(:latest_information)}</a></li>"
      html += _sub_menu(link)
      html += "</ul></li>"
    end
    html += "</ul></div>"
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
    if [:p_job, :p_buy_and_sell,:p_well_being].include? link
      html += "<li><a href=\"#{Okboard.okboard_link_write(link)}\" tabindex=\"-1\">#{t(:write_new)}</a></li>"
    end
    #html += _script(%Q|$('\#menu_#{link}').click(function(){$(this).text('#{t("menu_toggle_show")}');$('\#sub_menu_#{link}').toggle('slow');return false;})|)
    html.html_safe
  end

end
