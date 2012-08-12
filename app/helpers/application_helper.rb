module ApplicationHelper
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

  # Create banner
  def _collectImage(p, s, a)
    page_id = Style.pageid(p)
    section_id = Style.sectionid(s)
    position_id = a
    b = Banner.where("page_id = ? AND section_id = ? AND position_id = ?", page_id, section_id, position_id).first
    raise "Bad Argument #{p} > #{s} > #{a} page_id: #{page_id} section_id: #{section_id}" if b.nil?
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
      logger.debug("_banner okbrisbane: #{okbrisbane.nil?}")
      if !okbrisbane.nil?
        contact = "#{t('banner_contact')} #{okbrisbane.business_phone} #{okbrisbane.business_email}"
      else
        contact = "#{t('banner_contact')}"
      end
      html += %Q|<div class="banner_description" id="banner_description_#{div_id}"><p class='description_content'>#{contact}</p></div>|
      script = %Q|$('\##{div_id}').attr("style", "#{style};background:\#12345;border:1px solid #c0c0c0;");|
      html += _script_document_ready(script)
    elsif
    html += %Q|<div id="#{div_id}">|
      # Flash banner
      if images.size == 1 && images.first.flash?
        html += %Q|<div style="margin: 0px 2px 0px;float:left">
          <object data="#{images.first.flash_url}" type="application/x-shockwave-flash" width="#{b.img_width}px" height="#{b.img_height}px">
          <param name="movie" value="#{images.first.flash_url}" />
          </object></div>|
      elsif
        if b.div_width.to_i == b.img_width.to_i
          count = 0
        else
          count = b.div_width.to_i.div(b.img_width.to_i)
        end
        Rails.logger.debug("View banner count: #{count} b.div_width: #{b.div_width} b.img_width: #{b.img_width} effect: #{b.effect}")
        if b.effect.eql?(Banner::E_FIX) && count == 0
          html += %Q|<div style="margin: 0px 2px 0px;float:left">|
          if b.is_random 
            _index = rand(images.size)
          else
            _index = 0
          end
          html += one_image(b,images[_index])
          html += "</div>"
        elsif b.effect.eql?(Banner::E_FIX) && count > 0
          1.upto(count) do |x|
            html += %Q|<div style="margin: 0px 2px 0px;float:left">|
            if b.is_random 
              _index = rand(images.size)
            else
              _index = x - 1
            end
            html += one_image(b,images[_index])
            html += "</div>"
          end
        elsif b.effect.eql?(Banner::E_MSLIDE) && count > 0
          html += %Q|<a class="#{div_id}_prev" href="#" style="position:absolute;top:35px;left:-10px;">| + image_tag("common/bg_box_prev.gif") + "</a>"
          html += %Q|<a class="#{div_id}_next" href="#" style="position:absolute;top:35px;right:-10px;">| + image_tag("common/bg_box_next.gif") + "</a>"
          html += %Q|<div class="#{div_id}_slides_container">|
          images.each_with_index do |image,index|
            if index == 0
              Rails.logger.debug("index: #{index}")
              html += %Q|<div><div style="margin: 0px 2px 0px">|
            elsif index%count == 0
              Rails.logger.debug("index: #{index} count: #{count}")
              html += %Q|</div></div><div><div style="margin: 0px 2px 0px">|
            end
            html += %Q|<img src="#{image.original_image}" style="margin:0 3px 0" width="#{b.img_width}px" height="#{b.img_height}px"/>|
            if !image.caption.nil? && !image.caption.empty?
              html += %Q|<div class="caption"><p>#{image.caption}</p></div>|
            end
          end
          html += "</div></div></div>"
        else
          html += %Q|<div class="#{div_id}_slides_container">|
          images.each_with_index do |image,index|
            html += %Q|<div style="margin: 0px 2px 0px;float:left"><img src="#{image.original_image}" width="#{b.img_width}px" height="#{b.img_height}px"/>|
            if !image.caption.nil? && !image.caption.empty?
              html += %Q|<div class="caption"><p>#{image.caption}</p></div>|
            end
            html += "</div>"
          end
          html += "</div>"
        end
      end
      html += "</div>"
    end
    html += "</div>"
    return html.html_safe
  end
  
  def one_image(b, image)
    html = %Q|<img src="#{image.original_image}" width="#{b.img_width}px" height="#{b.img_height}px"/>|
    if !image.caption.nil? && !image.caption.empty?
       html += %Q|<div class="caption"><p>#{image.caption}</p></div>|
    end
    html.html_safe
  end

  def single_header_banner(a)
    logger.debug("single_header_banner @okpage: #{@okpage} a: #{a}")
    raise "No Page found(single_header_banner a=#{a})" if !@okpage
    single_banner(@okpage.to_sym, :s_header, a)
  end

  def single_body_banner(a)
    logger.debug("single_body_banner @okpage: #{@okpage} a: #{a}")
    raise "No Page found(single_body_banner a=#{a})" if !@okpage
    single_banner(@okpage.to_sym, :s_body, a)
  end

  def single_background_banner(a)
    logger.debug("single_background_banner @okpage: #{@okpage} a: #{a}")
    raise "No Page found(single_background_banner a=#{a})" if !@okpage
    single_banner(@okpage.to_sym, :s_background, a)
  end

  def multi_body_banner(a)
    logger.debug("multi_body_banner @okpage: #{@okpage} a: #{a}")
    raise "No Page found(multi_body_banner a=#{a})" if !@okpage
    multi_banner(@okpage.to_sym, :s_body, a)
  end

  def single_banner(p, s, a)
    logger.debug("requested single_banner #{p}, #{s}, #{a}")
    div_id = Style.create_banner_div(p,s,a)
    b,images = _collectImage(p,s,a)
    return "" if b.is_disabled
    html = _banner(p, s, a, div_id)
    script = ""
    if images.size >= 2
      case b.effect
      when Banner::E_SLIDE
        container = div_id + "_slides_container"
        effect_speed = b.effect_speed * 1000
        effect = Style.getEffect(p,s,a)
        logger.debug("BannerEffect: #{b.effect} s: #{effect_speed} effect: #{effect}")
        script += %Q|$('\##{div_id}').slides({container:'#{container}',
          preloadImage:'assets/common/loading.gif',|
          script += "randomize:true," if b.is_random
          script += %Q|play:#{effect_speed},#{effect}});
          $("a.prev").text('#{t("effect_prev")}');
          $("a.next").text('#{t("effect_next")}');|
        logger.debug("script: #{script}")
        html += _script_document_ready(script)
      end
    end
    html.html_safe
  end

  def _price(price)
    number_to_currency(price, :locale => 'en')
  end

  def navigation(over, out)
    html = %Q|<div id="navigation"><ul class="">|
    Style::NAVI.each do |key, value|
      html += %Q|<li class="navi" id="navi_#{value}">#{t(value)}</li>|
    end
    script = ""
    Style::NAVI.each do |key, value|
      script += %Q|$('\#navi_#{value}').click(function() { window.location.href ="#{_okboard_link(value)}| + %Q|"});|
    end
    html += _script_document_ready(script)
    html += "</ul></div>"
    html.strip.html_safe
  end

  def _okpage_v(okpage)
    Common.encrypt_data(okpage.to_s).chop
  end

  def _okboard_link(okpage)
    %Q|/okboards?v=| + _okpage_v(okpage)
  end

  def _okboard_link_with_id(okpage, id)
    %Q|/okboards/view?v=| + _okpage_v(okpage) + "&d=" + Common.encrypt_data(id.to_s).html_safe
  end
  
  def _okboard_link_upload_image(okpage)
    %Q|/okboards/upload_image?v=| + _okpage_v(okpage)
  end
  
  def _okboard_link_write(okpage)
    %Q|/okboards/write?v=| + _okpage_v(okpage)
  end

  def _okboard_link_with_category(okpage,category)
    _okboard_link(okpage) + "&c=" + Common.encrypt_data(category).html_safe
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
    if images.size >= 2
      case b.effect
      when Banner::E_MSLIDE
        container = div_id + "_slides_container"
        effect_speed = b.effect_speed * 1000
        effect = Style.getEffect(p,s,a)
        logger.debug("BannerEffect: #{b.effect} s: #{effect_speed} effect: #{effect}")
        script = %Q|$('\##{div_id}').slides({container:'#{container}',
          preloadImage:'assets/common/loading.gif',|
          #script += "randomize:true," if b.is_random
          script += %Q|play:#{effect_speed},next:'#{div_id}_next',prev:'#{div_id}_prev',#{effect}});|
        logger.debug("script: #{script}")
        html += _script_document_ready(script)
      end
    end
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

  def _truncate_no_title(expression)
    html = %Q|#{truncate(expression, :length => 26)}|
  end

  def noimage?(item)
    logger.debug("noimage? item: #{item}")
    if item.respond_to? :client_image
      if item.client_image.nil? || item.client_image.empty?
        logger.debug("noimage")
        return noimage
      end
    elsif item.respond_to? :image
      if item.image.nil? || item.image.empty?
        logger.debug("noimage")
        return noimage
      end
      logger.debug("item.image: #{item.image}")
    else
      raise "Internal Error #{item.class}"
    end
    return ""
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
