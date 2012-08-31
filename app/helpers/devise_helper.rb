module DeviseHelper
  # This is overwritten from Devise::DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg, :class => "devise_error") }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    messages.sub!('Email',I18n.t("email"))
    messages.sub!('Password',I18n.t("password"))

    html = <<-HTML
    <div class="devise_error_explanation">
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
