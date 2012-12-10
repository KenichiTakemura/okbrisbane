module OkBannersHelper

  def _show_banner(b, div_id, scroll_size, ajax_path) 
    params = %Q|b: '#{b.id}', div: '#{div_id}'|
    post_script = Ajax.post(ajax_path, params)
    html = %Q|$('\##{div_id}').html("| + escape_javascript(image_tag("common/ajax_loading_1.gif")) + %Q|");|
    html += post_script
    return html.html_safe if !scroll_size.present?
    scroll_html = %Q|var #{div_id}_banner = false;
        $(function() {
        $(window).scroll(function () {
          if ($(this).scrollTop() > #{scroll_size}) {
            if(!#{div_id}_banner){
            #{html};#{div_id}_banner = true;}}})})|
    scroll_html.html_safe
  end
  
  def _show_single_banner(b, div_id, scroll_size)
    _show_banner(b, div_id, scroll_size, show_single_banner_banners_path)
  end

  def _show_multi_banner(b, div_id, scroll_size)
    _show_banner(b, div_id, scroll_size, show_multi_banner_banners_path)
  end
  
  def single_header_banner(a, scroll_size=nil)
    raise "No Page found(single_header_banner a=#{a})" if !@okpage
    single_banner(Style.page(@okpage), :s_header, a, scroll_size)
  end

  def single_body_banner(a, scroll_size=nil)
    raise "No Page found(single_body_banner a=#{a})" if !@okpage
    single_banner(Style.page(@okpage), :s_body, a, scroll_size)
  end

  def single_background_banner(a, scroll_size=nil)
    raise "No Page found(single_background_banner a=#{a})" if !@okpage
    single_banner(Style.page(@okpage), :s_background, a, scroll_size)
  end

  def multi_body_banner(a, scroll_size=nil)
    raise "No Page found(multi_body_banner a=#{a})" if !@okpage
    multi_banner(Style.page(@okpage), :s_body, a, scroll_size)
  end
  
end
