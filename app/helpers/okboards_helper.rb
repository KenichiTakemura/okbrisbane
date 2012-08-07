module OkboardsHelper
  def author_name(post)
    return "" if post.nil?
    logger.debug("posted_by: #{post.posted_by_type}")
    if post.posted_by_type.eql? "Admin"
      return t('admin')
    else
    post.posted_by.email
    end
  end

  def author_email(post)
    return "" if post.nil?
    logger.debug("posted_by: #{post.posted_by_type}")
    if post.posted_by_type.eql? "Admin"
      return Okvalue::ADMIN_EMAIL
    else
    post.posted_by.email
    end
  end

  def section_span(post)
    logger.debug("section_span post: #{post.id}")
    html = "<span>"
    html += noimage?(post)
    html += image_tag(post.image.first.avatar.url(:medium)) if !post.image.empty?
    html += %Q|<p class="okboard_subject">| +  post.subject + "</p>"
    if post.respond_to?(:price)
      html += %Q|<p class="price_tag">| + number_to_currency(post.price, :locale => 'en')
      if @okpage.to_s.eql? Style.page(:p_motor_vehicle)
        html += "<br/>" + t("drive_away")
      end
      html += "</p>"
    end
    html += %Q|<p class="okboard_description">|
    html += raw(post.content.body) if !post.content.nil?
    html += "</p>"
    html += link_to(t("more"), _okboard_link(Style.page(@okpage)) << "&bd=#{post.id}") + " | "
    html += mail_to(author_email(post), t("contact_person"), :encode => "hex")
    html += "</span>"
    html.html_safe
  end

  def build_board_list(header, price)
    Rails.logger.debug("build_board_list #{header} #{price}")
    html = %Q|<table class="table">|
    if header
      html += %Q|<tr><th class="first">| + t("category") + "</th><th>"
      if price
        html += t("price") + "</th><th>"
      end
      html += t("subject") + "</th><th>" + t("created_at") + "</th><th>" + t("viewed") +  %Q|</th><th class="last">| + t("view") + %Q|</th></tr>|
    end
    html += "<tbody>"
    html += build_body_list_body(price)
    html += "</tbody></table>"
    html.html_safe
  end

  def build_body_list_body(price)
    html = ""
    if @board_lists.empty?
      html += %Q|<tr><td colspan="5">| + t("no_information")
      html += "</td><tr>"
    else
      @board_lists.each do |post|
        html += %Q|<tr class="okboard_list_body"><td class="first">| + t("#{post.category}") + %Q|</td><td>|
        if price
          html += "#{_price(post.price)}" + " </td><td>"
        end
        html += _truncate_no_title(post.subject) + "</td><td>" +
        Common.date_format(post.updated_at) + %Q|</td><td>| + t("viewed") + " " + post.views.to_s + "</td>" + %Q|<td class="okboard_list_view last">| + t("view") +
        section_span(post) + "</td></tr>"
      end
    end
    html.html_safe
  end

  def _path(links)
    path = Array.new
    links.each do |link|
      path.push(_okboard_link(link))
    end
    path
  end

  def _left_side_menu()
    html = %Q|<div id="page_section_left">|
    html += single_body_banner(1)
    html += %Q|<div id="okboard_let_menu"><ul class="okboard_left_menu_items">|
    case @okpage
    when :p_job
      links = [Style.page(:p_job),Style.page(:p_buy_and_sell),Style.page(:p_wellbeing),
        Style.page(:p_estate),Style.page(:p_motor_vehicle),Style.page(:p_business),
        Style.page(:p_accommodation),Style.page(:p_law),Style.page(:p_tax),
        Style.page(:p_study),Style.page(:p_immig),Style.page(:p_yellowpage),Style.page(:p_mypage)]
      paths = _path(links)
    when :p_buy_and_sell
      links = [Style.page(:p_buy_and_sell),Style.page(:p_job),Style.page(:p_wellbeing),
        Style.page(:p_estate),Style.page(:p_motor_vehicle),Style.page(:p_business),
        Style.page(:p_accommodation),Style.page(:p_law),Style.page(:p_tax),
        Style.page(:p_study),Style.page(:p_immig),Style.page(:p_yellowpage),Style.page(:p_mypage)]
      paths = _path(links)
    when :p_estate
      links = [Style.page(:p_estate),Style.page(:p_motor_vehicle),Style.page(:p_business),
        Style.page(:p_accommodation),Style.page(:p_job),Style.page(:p_buy_and_sell),
        Style.page(:p_wellbeing),Style.page(:p_law),Style.page(:p_tax),
        Style.page(:p_study),Style.page(:p_immig),Style.page(:p_yellowpage),Style.page(:p_mypage)]
      paths = _path(links)
    when :p_motor_vehicle
      links = [Style.page(:p_motor_vehicle),Style.page(:p_estate),Style.page(:p_business),
        Style.page(:p_accommodation),Style.page(:p_job),Style.page(:p_buy_and_sell),
        Style.page(:p_wellbeing),Style.page(:p_law),Style.page(:p_tax),
        Style.page(:p_study),Style.page(:p_immig),Style.page(:p_yellowpage),Style.page(:p_mypage)]
      paths = _path(links)
    when :p_business
      links = [Style.page(:p_business),Style.page(:p_estate),Style.page(:p_motor_vehicle),
        Style.page(:p_accommodation),Style.page(:p_job),Style.page(:p_buy_and_sell),
        Style.page(:p_wellbeing),Style.page(:p_law),Style.page(:p_tax),
        Style.page(:p_study),Style.page(:p_immig),Style.page(:p_yellowpage),Style.page(:p_mypage)]
      paths = _path(links)
    else
    raise "Not implemented"
    end
    links.each_with_index do |link,i|
      html += %Q|<li class="okboard_left_menu_item" id="_#{link}">|
      html += link_to(t("menu_toggle_show"), "#", :id => "menu_#{link}", :style => "float:left; margin-right: 10px;")
      html += link_to(t(link), paths[i], :class => "okboard_left_menu_link")
      html += %Q|<div id="sub_menu_#{link}" style="display:none">|
      html += _sub_menu(link)
      html += "</li>"
    end
    html += "</ul></div>"
    html += single_body_banner(2)
    html += single_body_banner(3)
    html += single_body_banner(4)
    html += "</div>"
    html.html_safe
  end

  def _sub_menu(link)
    logger.debug("_sub_menu @okpage: #{@okpage} link: #{link}")
    case link
    when Style.page(:p_job)
      categories = Job::Categories
    when Style.page(:p_buy_and_sell)
      categories = BuyAndSell::Categories
    when Style.page(:p_motor_vehicle)
      categories = MotorVehicle::Categories
    when Style.page(:p_estate)
      categories = Estate::Categories
    when Style.page(:p_business)
      categories = Business::Categories
    when Style.page(:p_accommodation)
      categories = Accommodation::Categories
    else
    return ""
    end
    logger.debug("categories: #{categories}")
    html = "<ul>"
    categories.each do |key,category|
      html += "<li>" + link_to(t(category), _okboard_link_with_category(link,category)) + "</li>"
    end
    html += "</ul>"
    html += _script(%Q|$('\#menu_#{link}').click(function(){$(this).text('#{t("menu_toggle_show")}');$('\#sub_menu_#{link}').toggle('slow');return false;})|)
    html.html_safe
  end

end
