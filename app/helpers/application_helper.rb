module ApplicationHelper
  # Create banner
  def _collectImage(p, s, a)
    page = Page.find_by_name(Style::PAGES[p])
    section = Section.find_by_name(Style::SECTIONS[s])
    position = a
    b = Banner.where("page_id = ? AND section_id = ? AND position_id = ?", page, section, position).first
    raise "Bad Argument #{p} > #{s} > #{a}" if b.nil?
    logger.debug("banner: #{b}")
    images = b.client_image
    return b, images
  end
  
  def _banner(p, s, a, div_id)
    b,images = _collectImage(p,s,a)
    style = "#{b.style};width:#{b.div_width}px;height:#{b.div_height}px;margin: 5px 0px 5px;"
    logger.debug("div_id #{div_id} style: #{style}")
    html = %Q|<div id="#{div_id}" style="#{style}">|
    if images.empty?
      html += %Q|<style>div.banner_description {position:absolute;top:0px;left:0px;background-color:black;opacity: 0.6;filter: alpha(opacity=60);}|
      html += %Q| div.banner_description p.description_content {padding:10px;margin:0px;font-size:12px;font-weight:bold;color:white;}</style>|
      okbrisbane = BusinessClient.okbrisbane.first
      html += %Q|<div class="banner_description" id="banner_description_#{div_id}"><p class='description_content'>#{t('banner_contact')} #{okbrisbane.business_phone} #{okbrisbane.business_email}</p></div>|
      script = %Q|$('\##{div_id}').attr("style", "#{style};background:\#12345;border:1px solid #c0c0c0;");|
      html += _script_document_ready(script)
    elsif
      html += %Q|<div id="effect_#{div_id}"><div class="effect_container_#{div_id}">|
      images.each do |image|
        html += %Q|<div style="margin: 0px 2px 0px;float:left"><img src="#{image.avatar.url(:original)}" width="#{b.img_width}px" height="#{b.img_height}px"/></div>|
      end
      html += "</div></div>"
    end
    html += "</div>"
    return html.html_safe
  end
  
  def single_banner(p, s, a)
    logger.debug("requested single_banner #{p}, #{s}, #{a}")
    div_id = Style.create_banner_div(p,s,a)
    b,images = _collectImage(p,s,a)
    html = _banner(p,s, a, div_id)
    script = ""
    if images.size >= 2
      #script += %Q|$('\##{div_id}').cycle({fx: 'scrollRight',random: 1});|
      case b.effect
      when Banner.E_SLIDE
      when Banner.E_SLIDE_W_CAPTION
      when Banner.NO_SLIDE
      end
      script += %Q|$('\##{div_id}').cycle({fx: 'fade',random: 1,timeout: 100});|
      html += _script_document_ready(script)
    end
    html.html_safe
  end

  def _price(price)
   '%.2f' % price
  end

  def navigation(over, out)
     logger.debug("navigation")
     html = %Q|<div id="navigation"><ul class="slide">|
     Style::NAVI.each do |key, value|
      html += %Q|<li class="navi" id="navi_#{value}">#{t(value)}</li>|
     end
     script = ""
     Style::NAVI.each do |key, value|
      script += %Q|$('\#navi_#{value}').mouseover(function() { $(this).attr("style", "background: #{over}");}).mouseout(function(){$(this).attr("style", "background: #{out}");});|
     end
     html += _script_document_ready(script)
     html += "</ul></div>"
     html.strip.html_safe
  end
  
  def _script_document_ready(script)
    html = %Q|<script type="text/javascript" charset="utf-8">$(document).ready(function() {#{script}});</script>|
    html.html_safe
  end
  
  def _script(script)
    %Q|<script type="text/javascript" charset="utf-8">#{script}</script>|.html_safe
  end
  
  def multi_banner(p, s, a)
    logger.debug("requested multi_banner #{p}, #{s}, #{a}")
    div_id = Style.create_banner_div(p,s,a)
    b,images = _collectImage(p,s,a)
    html = _banner(p,s, a, div_id)
    logger.debug("html: #{html}")
    html.html_safe
  end
  
  def version
    "Version 0.1"
  end
  
  def thumbnail(image, action)
    logger.debug("delete_action: #{action}")
    html = %Q|<div style="position: relative; float: left; width:#{image.width}px; height: #{image.height}px; margin-left: 5px">|
    html += link_to(image_tag(image.avatar.url(:thumb), :class => 'thumbnail'), image.avatar.url(:original), :target => "_blank")
    html += %Q|<div style="position: absolute; top: 0px; left:95%;">|
    html += link_to(t('x'), action, method: :delete, data: { confirm: t('confirm_delete') }, :remote => true, :class => 'delete_x', :title => t('delete'))
    html += "</div></div>"
    html.html_safe
  end
  
  def _truncate(expression)
    html = %Q|<span title="#{expression}">#{truncate(expression, :length => 26)}</span>|
    html.html_safe
  end
  
  def _truncate_with_length(expression, length)
    html = %Q|<span title="#{expression}">#{truncate(expression, :length => length)}</span>|
    html.html_safe
  end
  
  def noimage?(item)
    logger.debug("noimage? item: #{item}")
    if item.respond_to? :client_image
      if item.client_image.nil? || item.client_image.empty?
      return noimage
      end
   elsif item.respond_to? :image
      if item.image.nil? || item.image.empty?
       return noimage
      end
   end
 end
  
  # Used to show no image
  def noimage
    html = %Q|<img src="/assets/noimage.jpg" width="50px" height="50px" />|
    html.html_safe
  end
  
  def _upload(category, item_id)
    html = <<-HTML
    <style>
    \#dropbox {
      width: 300px;
      height: 100px;
      border: 1px solid gray;
      border-radius: 5px;
      padding: 5px;
      color: #41A317;
    }
  </style>
  <script type="text/javascript">
    window.onload = function() {
      var dropbox = document.getElementById("dropbox");
      dropbox.addEventListener("dragenter", noop, false);
      dropbox.addEventListener("dragexit", noop, false);
      dropbox.addEventListener("dragover", noop, false);
      dropbox.addEventListener("drop", dropUpload, false);
    };
    function noop(event) {
      event.stopPropagation();
      event.preventDefault();
    };
    function dropUpload(event) {
      noop(event);
      var files = event.dataTransfer.files;
      for (var i = 0; i < files.length; i++) {
        upload(files[i]);
      }
    };
    function upload(file) {
      $('\#dropbox_status').html("Uploading " + file.name);
      var formData = new FormData();
      formData.append("id", #{item_id});
      formData.append("file", file);
      formData.append("authenticity_token", $("input[name='authenticity_token']").attr("value"));
      var xhr = new XMLHttpRequest();
      xhr.upload.addEventListener("progress", uploadProgress, false);
      xhr.addEventListener("load", uploadComplete, false);
      xhr.open("POST", "/#{category}/upload", true);
      xhr.send(formData);
    };
    function uploadProgress(event) {
      var progress = Math.round((event.loaded / event.total) * 100);
      $('\#dropbox_status').html("Progress " + progress + "%");
    };
    function uploadComplete(event) {
      if (event.target.status != 200) {
        $('\#dropbox_status').html("<div class=\\"message error\\">"
        + "<p><strong>Oops!</strong> Could not handle request. </p></div>");
        return false;
      }
      data = JSON.parse(event.target.responseText);
      $('\#dropbox_status').html("<div class=\\"message notice\\">"
      + "<p><strong>" + data.result + "</strong></p></div>");
      ids = data.images;
      w = data.w
      h = data.h
      images_t = data.images_t;
      images_o = data.images_o;
      var html = "";
      for (var i=0; i<ids.length; i++) {
        html += '<div style="position: relative; float: left; width:" + w[i] + "px; height:" + h[i] + "px; margin-left: 5px">';
        html += '<a href="' + images_o[i] + '"><img class=thumbnail src="' + images_t[i] + '"/></a>';
        html += '<div style="position: absolute; top: 0px; left:95%;">';
        html += '<a href="/sales_managements/#{item_id}/image?category=#{category}&image=' + ids[i] + '" class="delete_x" rel="nofollow" data-remote="true" data-method="delete" data-confirm="#{t('confirm_delete')}" title="#{t('delete')}">' + "#{t('x')}" + "</a>"
        html += "</div></div>"
      }
      $('\#thumbnail_box_#{item_id}').html(html);
    };
  </script>
  <div class="flash">
  <div id="dropbox_status"></div>
  </div>
  <div style="postion:relative" id="dropbox">
    <p>
      <strong>#{I18n.t('please_drag_n_drop')}</strong>
    </p>
  </div>
   HTML
  html.html_safe
  end
end
