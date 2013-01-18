module SnsHelper
    
  def facebook
     html = %Q|<a data-original-title="#{t(:facebook_login)}" id="popover_facebook" href="#{user_omniauth_authorize_path(:facebook)}" class="" data-placement="bottom"  rel="popover" data-content="#{t(:facebook_login_exp)}">#{image_tag("f_logo.png", :class => "image-resize30_30")}</a>|
     html += _script_document_ready(%Q|
                $('\#popover_facebook').popover({trigger:'hover'});|)
     html = %Q|<a href="#{user_omniauth_authorize_path(:facebook)}" class="">#{image_tag("f_logo.png", :class => "image-resize30_30")}&nbsp;#{t(:signin)}</a>|
     html.html_safe

  end
  
  def google
     html = %Q|<a data-original-title="#{t(:google_login)}" id="popover_google" href="#{root_path}" class="" data-placement="bottom"  rel="popover" data-content="#{t(:google_login_exp)}">#{image_tag("google_logo_3D_online_small.png", :class => "")}</a>|
     html += _script_document_ready(%Q|
                $('\#popover_google').popover({trigger:'hover'});|)
     html = %Q|<a href="#{user_omniauth_authorize_path(:facebook)}" class="">#{image_tag("google_logo_3D_online_small.png", :class => "")}&nbsp;#{t(:signin)}</a>|           
     html.html_safe
  end
  
  def show_user(user=nil)
    html = ""
    return "" if user.nil? && !current_user
    if user.nil?
      user = current_user
    end
    if user.user_url.present?
      html += %Q|<a href="#{user.user_url}">#{user.user_name}</a>|
    else
      html += user.user_name
    end
    if user.user_image.present?
      html += "&nbsp;" + image_tag(user.user_image, :alt => "")
    end
    html.html_safe
  end
  
  def fb_shout
    html = ""
    token = Common.unique_token
    if current_user && current_user.facebook_user? 
      html = %Q|<a href="\#" onclick='facebook_shout_#{token}(); return false;' class="btn"><i class="icon-facebook-sign"></i>#{t("facebook.shout")}</a>|
      html += %Q|<p id='msg_#{token}'></p>|
      html += _script(%Q|
        function facebook_shout_#{token}() {
          // calling the API ...
          var obj = {
            method: 'feed',
            link: '#{root_url}',
            source: '#{root_url}',
            name: '#{t("facebook.wall")}',
            caption: '#{t("facebook.caption")}',
            description: '#{t("facebook.desc")}',
            picture: '#{root_url}/logo_fb.gif'
          };
          #{fb_callback_handler(token)}
          FB.ui(obj, callback);
        }
      |)
    end
    html.html_safe
  end
  
  def fb_callback_handler(token)
     html = <<-HTML
        function callback(response) {
            if(response['post_id'] != null) {
              document.getElementById('msg_#{token}').innerHTML = '#{escape_javascript(show_notice(t("facebook.shouted")))}';
            } else {
              document.getElementById('msg_#{token}').innerHTML = '#{escape_javascript(show_notice(t("facebook.failed")))}';     
            }
          }
     HTML
     html.html_safe
  end
  
end
