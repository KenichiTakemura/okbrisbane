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
    logger.debug("section_span post: #{post.id}")
    html = "<span>"
    html += noimage?(post)
    html += image_tag(post.image.first.medium_image, :size => post.image.first.medium_size) if !post.image.empty?
    html += %Q|<p class="okboard_subject">| +  post.subject + "</p>"
    if post.respond_to?(:price)
      html += %Q|<p class="price_tag">| + post.price
      html += "</p>"
    end
    html += %Q|<p class="okboard_description">|
    html += raw(post.content.body) if !post.content.nil?
    html += "</p>"
    html += link_to(image_tag("#{I18n.locale}/common/btn_info_view.gif"), Okboard.okboard_link_with_id(category, post.id))
    #html += mail_to(author_email(post), t("contact_person"), :encode => "hex")
    html += "</span>"
    html.html_safe
  end

  def build_board_list
    html = %Q|<table id="okboard_table" width=100% class="ui-widget">
        <thead class="ui-widget-header"><tr><th>#{t("category")}</th><th>|
    if [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_buy_and_sell].include?(@okpage)
      html += t("price") + "</th><th>"
    end
    html += %Q|#{t("subject")}</th><th>#{t("created_at")}</th><th>#{t("viewed")}</th><th>#{t("comment")}</th>
    <th>#{t("image")}</th><th>#{t("attachment")}</th><th>#{t("author")}</th><th width=5%>#{t("view")}</th></tr></thead>|
    html += %Q|<tbody class="ui-widget-content">|
    if @board_lists.empty?
      if [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_buy_and_sell].include?(@okpage)
        html += %Q|<tr><td colspan="10">| + t("no_information")
      else
        html += %Q|<tr><td colspan="9">| + t("no_information")
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
      html += %Q|#{_truncate_with_length(post.subject, 35)}</td><td>
       #{post.postedDate}</td><td>#{post.views}</td><td>| + image_tag("#{I18n.locale}/common/say.png") + "#{post.comment.size}</td><td>"
      if post.has_image?
        html += image_tag("common/IconData2.gif") + post.image.size.to_s
      end
      html += "</td><td>"
      if post.has_attachment?
        html += image_tag("common/IconData2.gif")
      end
      html += %Q|</td><td >| + link_to(author_name(post), Okboard.okboard_link_with_user(@okpage, post.posted_by_id), :style => "color:#000") + %Q|</td><td class="okboard_list_view">|
      #if [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation].include?(@okpage)
      #  html += t("view") + section_span(post) + "</td></tr>"
      #else
        html += link_to(image_tag("#{I18n.locale}/common/view_1.gif", :style => "margin-top:2px"), Okboard.okboard_link_with_id(@okpage, post.id, @post_search.id))
      #end
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

  def _left_side_menu()
    html = %Q|<div id="page_section_left">|
    html += single_body_banner(1)
    html += %Q|<div id="okboard_let_menu"><ul class="okboard_left_menu_items">|
    case @okpage
    when :p_job
      links = [:p_job,:p_buy_and_sell,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig,:p_yellowpage]
      paths = _path(links)
    when :p_buy_and_sell
      links = [:p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig,:p_yellowpage]
      paths = _path(links)
    when :p_well_being
      links = [:p_well_being,:p_job,:p_buy_and_sell,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_law,:p_tax,:p_study,:p_immig,:p_yellowpage]
      paths = _path(links)
    when :p_estate
      links = [:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig,:p_yellowpage]
      paths = _path(links)
    when :p_motor_vehicle
      links = [:p_motor_vehicle,:p_estate,:p_business,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig,:p_yellowpage]
      paths = _path(links)
    when :p_business
      links = [:p_business,:p_estate,:p_motor_vehicle,:p_accommodation,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig,:p_yellowpage]
      paths = _path(links)
    when :p_accommodation
      links = [:p_accommodation,:p_estate,:p_motor_vehicle,:p_business,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_law,:p_tax,:p_study,:p_immig,:p_yellowpage]
      paths = _path(links)
    when :p_law
      links = [:p_law,:p_tax,:p_study,:p_immig,:p_yellowpage,:p_mypage,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
      paths = _path(links)
    when :p_tax
      links = [:p_tax,:p_law,:p_study,:p_immig,:p_yellowpage,:p_mypage,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
      paths = _path(links)
    when :p_study
      links = [:p_study,:p_law,:p_tax,:p_immig,:p_yellowpage,
        :p_buy_and_sell,:p_job,:p_well_being,
        :p_estate,:p_motor_vehicle,:p_business,:p_accommodation]
      paths = _path(links)
    when :p_immig
      links = [:p_immig,:p_law,:p_tax,:p_study,:p_yellowpage,
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
        :p_law,:p_tax,:p_study,:p_immig,:p_yellowpage]
      paths = _path(links)
    else
      raise "Not implemented"
    end
    links.each_with_index do |link,i|
      html += %Q|<li class="okboard_left_menu_item" id="_#{link}">|
      html += link_to(t("menu_toggle_show"), "#", :id => "menu_#{link}", :style => "float:left; margin-right: 10px;")
      html += link_to(t(Style.page(link)), paths[i], :class => "okboard_left_menu_link")
      html += %Q|<div id="sub_menu_#{link}" style="display:none">|
      html += _sub_menu(link)
      html += "</li>"
    end
    html += "</ul></div>"
    html += %Q|<div class="okboard_left_fixed_banners">|
    html += single_body_banner(2)
    html += single_body_banner(3)
    html += single_body_banner(4)
    html += "</div></div>"
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
    html = "<ul>"
    categories.each do |key,category|
      html += "<li>" + link_to(t(category), Okboard.okboard_link_with_category(link,category)) + "</li>"
    end
    if [:p_job, :p_buy_and_sell,:p_well_being].include? link
      html += "<li>" + link_to(t('write_new'), Okboard.okboard_link_write(@okpage)) + "</li>"
    end
    html += "</ul>"
    html += _script(%Q|$('\#menu_#{link}').click(function(){$(this).text('#{t("menu_toggle_show")}');$('\#sub_menu_#{link}').toggle('slow');return false;})|)
    html.html_safe
  end

end
