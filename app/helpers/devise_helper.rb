module DeviseHelper
  # This is overwritten from Devise::DeviseHelper
  def devise_error_messages!
    if resource.errors.empty?
      return ""
    end

    messages = resource.errors.full_messages.map { |msg|
      show_alert_message(msg)
    }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    messages.sub!('Email',I18n.t(:email))
    messages.sub!('Password',I18n.t(:password))
    messages.sub!('Reset password token',I18n.t(:token))
    messages.sub!('User name',I18n.t(:name))
    

    html = <<-HTML
      #{messages}
    HTML

    html.html_safe
  end
  
  # Create left Menu
  def _left_menu(logo, links, paths)
    html = %Q|<div id="page_section_left">|
    if !logo.nil?
      html += image_tag(logo, :class => "logo")
    else
      html += single_body_banner(1)
    end
    html += _left_menu_select(links, paths)
    html += single_body_banner(2)
    html += single_body_banner(3)
    html += single_body_banner(4)
    html += "</div>"
    html.html_safe
  end
  
  def _left_menu_select(links, paths)
    html = %Q|<div id="menu"><ul class="nav nav-pills nav-stacked">|
    links.each_with_index do |link,i|
      html += %Q|<li id="_#{link}"><i class="icon-circle-arrow-right" style="float:right;margin-right:5px;margin-top:5px;"></i>|
      html += link_to(t(link), paths[i])
      html += "</li>"
    end
    html += "</ul></div>"
    html
  end
  
  def _left_menu_select_(links, paths)
    html = %Q|<div id="menu"><div class="items">|
    links.each_with_index do |link,i|
      html += %Q|<div class="item" id="_#{link}"><p class="menu-item">|
      html += link_to(t(link), paths[i], :class => "")
      html += "</p></div>"
    end
    html += "</div></div>"
    html
  end
  
  def active_menu(div_id)
    #_script_document_ready(%Q|$('##{div_id}').attr("style", "font-size:15px;font-weight:bold;background-color:#4E004E;opacity:1;filter:alpha(opacity=100);");|).html_safe
    _script_document_ready(%Q|$('##{div_id}').attr("class", "active");|).html_safe
  end
    
    
  
end
