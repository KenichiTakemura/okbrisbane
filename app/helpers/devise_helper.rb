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
end
