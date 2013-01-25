module SnsHelper
    
  def facebook
    html = ""
    token = Common.unique_token
    if facebook_signin?
      html = %Q|<a href="#{user_omniauth_authorize_path(:facebook)}" class="" id="facebook_signin_#{token}">#{image_tag("f_logo.png", :class => "image-resize30_30")}&nbsp;<span id="facebook_signin_text_#{token}">#{t(:signin)}</span></a>|
      html += _script(%Q|$(function(){
      $("\#facebook_signin_#{token}").click(function(){
          $("\#facebook_signin_text_#{token}").html("#{escape_javascript('<i class="icon-spinner icon-spin icon-large"></i>')}");
      });})|)
    end
    html.html_safe
  end
  
  def google
    html = ""
    token = Common.unique_token
    if google_signin?
      html = %Q|<a href="#{user_omniauth_authorize_path(:google_oauth2)}" class="" id="google_signin_#{token}">#{image_tag("google_logo_3D_online_small.png", :class => "")}&nbsp;<span id="google_signin_text_#{token}">#{t(:signin)}</span></a>|
      html += _script(%Q|$(function(){
      $("\#google_signin_#{token}").click(function(){
          $("\#google_signin_text_#{token}").html("#{escape_javascript('<i class="icon-spinner icon-spin icon-large"></i>')}");
      });})|)
    end
    html.html_safe
  end
  
  def naver
    html = ""
    token = Common.unique_token
    if naver_signin?
      html = %Q|<a href="#{user_omniauth_authorize_path(:naver)}" class="" id="naver_signin_#{token}">#{image_tag("img_naver.jpg", :class => "")}&nbsp;<span id="naver_signin_text_#{token}">#{t(:signin)}</span></a>|
      html += _script(%Q|$(function(){
      $("\#naver_signin_#{token}").click(function(){
          $("\#naver_signin_text_#{token}").html("#{escape_javascript('<i class="icon-spinner icon-spin icon-large"></i>')}");
      });})|)
    end
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
      html = %Q|<a href="\#" onclick='facebook_shout_#{token}(); return false;' class="btn btn-info"><i class="icon-facebook-sign"></i>#{t("facebook.shout")}</a>|
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
