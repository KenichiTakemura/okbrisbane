module OkBannersHelper

  def _show_banner(b, div_id) 
    params = %Q|b: '#{b.id}', div: '#{div_id}'|
    post_script = _post(show_banner_banners_path, params)
    html = %Q|$('\##{div_id}').html("| + escape_javascript(image_tag("common/ajax_loading_1.gif")) + %Q|");|
    html += post_script
    html.html_safe
  end
  
end
