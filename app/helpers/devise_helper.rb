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
  
  def active_menu(div_id)
    _script_document_ready(%Q|$('##{div_id}').addClass("btn-info");|).html_safe
  end
    
 
end
