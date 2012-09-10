module DeviseHelper
  # This is overwritten from Devise::DeviseHelper
  def devise_error_messages!
    Rails.logger.warn("Devise error: #{resource.errors}")
    if resource.errors.empty?
      Rails.logger.warn("Error is empty")
      return ""
    end

    messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg, :class => "devise_error") }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    Rails.logger.warn("message: #{messages}")
    messages.sub!('Email',I18n.t(:email))
    messages.sub!('Password',I18n.t(:password))
    messages.sub!('Reset password token',I18n.t(:token))
    messages.sub!('User name',I18n.t(:name))
    

    html = <<-HTML
    <div class="devise_error_explanation">
      #{messages}
    </div>
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
    html += %Q|<div id="menu"><div class="items">|
    links.each_with_index do |link,i|
      html += %Q|<div class="item" id="_#{link}"><p class="menu-item">|
      html += link_to(t(link), paths[i], :class => "non_style_link")
      html += "</p></div>"
    end
    html += "</div></div>"
    html += single_body_banner(2)
    html += single_body_banner(3)
    html += single_body_banner(4)
    html += "</div>"
    html.html_safe
  end
  
  def active_menu(div_id)
    _script_document_ready(%Q|$('##{div_id}').attr("style", "background-color: #41A317;opacity:1;filter:alpha(opacity=100);");|).html_safe
  end
    
    
  
end
