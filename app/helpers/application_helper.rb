module ApplicationHelper
  
  def admin_error_messages!(record)
    html = ""
    if record.errors.any?
      html += <<-HTML
      <div id="error_explanation">
      </div>
      HTML
    end
    html.html_safe
  end
  
  def ok_error_messages!(resource)
    if resource.errors.empty?
      return ""
    end

    messages = resource.errors.full_messages.map { |msg|
      show_alert_message(msg)
    }.join

    messages.gsub!('Email',I18n.t(:email))
    messages.gsub!('User name',I18n.t(:name))
    messages.gsub!('Phone',I18n.t(:phone))
    messages.gsub!('Body',I18n.t(:content))
    messages.gsub!('Subject',I18n.t(:subject))
    messages.gsub!('Content body',I18n.t(:content))

    html = <<-HTML
      #{messages}
    HTML

    html.html_safe
  end
  
  def author_name(post)
    return "" if post.nil?
    logger.debug("posted_by: #{post.posted_by_type}")
    if post.posted_by_type.eql? "Admin"
      return t('admin')
    else
      return post.posted_by.name if !post.posted_by.nil?
    end
    t("unknown_user")
  end
  
  def comment_author(comment)
    if comment.commented_by
       return comment.commented_by.name
    end
    t("unknown_user")
  end
  
  def socialable?
    SystemConfig.instance.socialable
  end
  
  def top_page_ajaxable?
    SystemConfig.instance.top_page_ajax
  end

  def banner_clickable?
    SystemConfig.instance.banner_clickable
  end
  
  def banner_ajaxable?
    SystemConfig.instance.banner_ajaxable    
  end

 # Create banner
  def _collectImage(p, s, a)
    logger.debug("_collectImage: #{p} #{s} #{a}")
    page_id = Style.pageid_value(p)
    logger.debug("page_id: #{page_id}")
    section_id = Style.sectionid(s)
    position_id = a
    b = Banner.where("page_id = ? AND section_id = ? AND position_id = ?", page_id, section_id, position_id).first
    raise "Bad Argument #{p} > #{s} > #{a} page_id: #{page_id} section_id: #{section_id}" if b.nil?
    logger.debug("banner: #{b}")
    images = b.client_image
    return b, images
  end
  
  def _generate_empty_banner(style, div_id)
    html = ""
    html += %Q|<style>div.banner_description {position:absolute;top:0px;left:0px;background-color:black;opacity: 0.6;filter: alpha(opacity=60);}|
    html += %Q| div.banner_description p.description_content {padding:10px;margin:0px;font-size:12px;font-weight:bold;color:white;}</style>|
    contact = "#{t('banner_contact')}"
    if request.host =~ /admin.okbrisbane/
      html += %Q|<div class="banner_description" id="banner_description_#{div_id}"><p class='description_content'>#{contact}</p></div>|
    else
      html += %Q|<div class="" id="banner_description_#{div_id}"><p class='description_content'>#{link_to_with_icon(contact,show_ok_sponsors_path(:t => Okvalue::CONTACT_BANNER),"btn btn-primary","","icon-info-sign icon-white")}#{}</p></div>|
    end       
    script = %Q|$('\##{div_id}').attr("style", "#{style};background:\#12345;border:1px solid #c0c0c0;");|
    html += _script_document_ready(script)
    html.html_safe
  end

  def _generate_banner(b, images, div_id)
      html = ""
      if images.size == 1 && images.first.flash?
        html += %Q|<div style="margin: 0px 2px 0px;float:left">
          <object data="#{images.first.flash_url}" type="application/x-shockwave-flash" width="#{b.img_width}px" height="#{b.img_height}px">
          <param name="movie" value="#{images.first.flash_url}" />
          </object></div>|
      else
        if b.div_width.to_i == b.img_width.to_i
          count = 0
        else
          count = b.div_width.to_i.div(b.img_width.to_i)
        end
        Rails.logger.debug("View banner count: #{count} b.div_width: #{b.div_width} b.img_width: #{b.img_width} effect: #{b.effect}")
        if b.effect.eql?(Banner::E_FIX) && count == 0
          html += %Q|<div style="margin: 0px 2px 0px;float:left">|
          if b.is_random 
            html += one_image(b,images[rand(images.size)])
          else
            html += one_image(b,images[0])
          end          
          html += "</div>"
        elsif b.effect.eql?(Banner::E_FIX) && count > 0
          _rand_index = Array.new
          1.upto(count) do |x|
            html += %Q|<div style="margin: 0px 2px 0px;float:left">|
            if b.is_random 
              _index = Common.random_index(_rand_index, images.size)
              _rand_index.push(_index)
            else
              _index = x - 1
            end
            html += one_image(b,images[_index])
            html += "</div>"
          end
        elsif b.effect.eql?(Banner::E_MSLIDE) && count > 0
          html += %Q|<div id="#{div_id}_#{Common.uniqe_token}">|
          html += %Q|<a class="#{div_id}_prev btn btn-primary" href="#" style="position:absolute;top:35px;left:-40px;"><i class="icon-step-backward icon-white"></i></a>|
          html += %Q|<a class="#{div_id}_next btn btn-primary" href="#" style="position:absolute;top:35px;right:-15px;"><i class="icon-step-forward icon-white"></i></a>|
          html += %Q|<style type="text/css" media="screen">
            .#{div_id}_slides_container {
                width:#{b.div_width}px;
                height:#{b.div_height}px;
            }
            .#{div_id}_slides_container div {
                width:#{b.div_width}px;
                height:#{b.div_height}px;
                display:block;
            }
          </style>|
          html += %Q|<div class="#{div_id}_slides_container">|
          images.each_with_index do |image,index|
            if index == 0
              html += %Q|<div style="height:#{b.img_height}px"><div style="margin: 0px 2px 0px">|
            elsif index%count == 0
              html += %Q|</div></div><div style="height:#{b.img_height}px"><div style="margin: 0px 2px 0px">|
            end
            #html += %Q|<img src="#{image.original_image}" style="margin:0 3px 0" width="#{b.img_width}px" height="#{b.img_height}px"/>|
            #if !image.caption.nil? && !image.caption.empty?
            #  html += %Q|<div class="caption"><p>#{image.caption}</p></div>|
            #end
            html += one_image(b,image,"margin:0 3px 0")
          end
          html += "</div></div></div>"
          html += "</div>"
        else
          html += %Q|<style type="text/css" media="screen">
          .#{div_id}_slides_container {width:#{b.img_width}px;height:#{b.img_height}px;}
          .#{div_id}_slides_container div {width:#{b.img_width}px;height:#{b.img_height}px;display:block;}
          </style>|
          html += %Q|<div class="#{div_id}_slides_container">|
          images.each_with_index do |image,index|
            html += %Q|<div style="margin: 0px 2px 0px;float:left">|
            html += one_image(b, image)
            html += "</div>"
          end
          html += "</div>"
          
        end
      end
      #html += "</div>"
    #html += "</div>"
    html.html_safe
  end
  
  def one_image(b, image, style=nil)
    Rails.logger.debug("one_image host : #{request.host}")
    if request.host =~ /admin.okbrisbane/
      html = image_tag(image.original_image, :style => style, :size => "#{b.img_width}x#{b.img_height}")
    else
      if banner_clickable?
        html = link_to(image_tag(image.original_image, :style => "width:#{b.img_width}px;height:#{b.img_height}px;#{style}"), Sponsor.sponsor_link_to(image.attached_id, image.id))
      else
        html = image_tag(image.original_image, :style => style, :alt => "Loading...", :size => "#{b.img_width}x#{b.img_height}")
      end
    end
    if !image.caption.nil? && !image.caption.empty?
       html += %Q|<div class="caption"><p>#{image.caption}</p></div>|
    end
    html.html_safe
  end
  
  def _banner_create(div_id, p, s, a, b, style, body)
    logger.debug("div_id #{div_id} style: #{style}")
    html = %Q|<div id="#{div_id}" style="#{style}">|
    html += body
    html += "</div>"
    html.html_safe
  end

  def single_banner(p, s, a, scroll_size=nil)
    b,images = _collectImage(p,s,a)
    return "" if b.is_disabled
    div_id = Style.create_banner_div(p,s,a)
    style = "#{b.style};width:#{b.div_width}px;height:#{b.div_height}px;margin: 5px 0px 5px;"
    if !images.present?
      return _banner_create(div_id,p,s,a,b,style,_generate_empty_banner(style,div_id))
    end
    if !(request.host =~ /admin.okbrisbane/)
      if banner_ajaxable? && scroll_size.to_i >= 0
        script = _script_document_ready(_show_single_banner(b,div_id,scroll_size))
        return _banner_create(div_id,p,s,a,b,style,script)
      end
    end
    html = _banner_create(div_id,p,s,a,b,style,_generate_banner(b,images,div_id))
    html = after_single_banner(b,images,div_id,html)
    html.html_safe
  end
  
  def after_single_banner(b,images,div_id,html)
    script = ""
    if images.size >= 2
      case b.effect
      when Banner::E_SLIDE
        container = div_id + "_slides_container"
        effect_speed = b.effect_speed * 1000
        effect = Style.getEffect(Style.pagename(b.page_id),Style.sectionname(b.section_id),b.position_id)
        logger.debug("BannerEffect: #{b.effect} s: #{effect_speed} effect: #{effect}")
        script += %Q|$('\##{div_id}').slides({container:'#{container}',
          preloadImage:'assets/common/ajax_loader_1.gif',|
        script += "randomize:true," if b.is_random
        script += %Q|play:#{effect_speed},#{effect}});|
        #$("a.prev").text('#{t("effect_prev")}');
        #$("a.next").text('#{t("effect_next")}');|
        #logger.debug("script: #{script}")
        html += _script_document_ready(script)
      end
    end
    html.html_safe
  end

  def _price(price)
    number_to_currency(price, :locale => 'en')
  end

  def navigation(over, out)
    html = %Q|<div id="navigation"><ul style="margin:0px">|
    Style::NAVI.each do |key|
      value = Style.page(key)
      html += %Q|<li class="navi" id="navi_#{value}">#{t(value)}</li>|
    end
    script = ""
    Style::NAVI.each do |key|
      value = Style.page(key)
      if key.eql?(:p_yellowpage)
        script += %Q|
        $('\#navi_#{value}').mouseover(function(){$(this).css("background-color","yellow")});
        $('\#navi_#{value}').mouseout(function(){$(this).css("background-color","")});
        $('\#navi_#{value}').click(function(){window.location.href ="#{yellowpage_okboards_path}| + %Q|"});|
      else
        script += %Q|
        $('\#navi_#{value}').mouseover(function(){$(this).css("background-color","#{Okvalue::COLORMAP[cycle("ok","naver","blue").to_sym]}")});
        $('\#navi_#{value}').mouseout(function(){$(this).css("background-color","")});
        $('\#navi_#{value}').click(function() { window.location.href ="#{Okboard.okboard_link(key)}| + %Q|"});|
      end
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

  def multi_banner(p, s, a, scroll_size=nil)
    logger.debug("requested multi_banner #{p}, #{s}, #{a}")
    b,images = _collectImage(p,s,a)
    return "" if b.is_disabled
    div_id = Style.create_banner_div(p,s,a)
    style = "#{b.style};width:#{b.div_width}px;height:#{b.div_height}px;margin: 5px 0px 5px;"
    if !images.present?
      return _banner_create(div_id,p,s,a,b,style,_generate_empty_banner(style,div_id))
    end
    if !(request.host =~ /admin.okbrisbane/)
      if banner_ajaxable?
        script = _script_document_ready(_show_multi_banner(b,div_id,scroll_size))
        return _banner_create(div_id,p,s,a,b,style,script)
      end
    end
    html = _banner_create(div_id,p,s,a,b,style,_generate_banner(b,images,div_id))
    html = after_multi_banner(b, images, div_id, html)
    html.html_safe
  end
  
  def after_multi_banner(b, images, div_id, html)
    if images.size >= 2
      case b.effect
      when Banner::E_MSLIDE
        container = div_id + "_slides_container"
        effect_speed = b.effect_speed * 1000
        effect = Style.getEffect(Style.pagename(b.page_id),Style.sectionname(b.section_id),b.position_id)
        logger.debug("BannerEffect: #{b.effect} s: #{effect_speed} effect: #{effect}")
        script = %Q|$('\##{div_id}').slides({container:'#{container}',
          preloadImage:'assets/common/ajax_loading_1.gif',|
          script += %Q|play:#{effect_speed},next:'#{div_id}_next',prev:'#{div_id}_prev',#{effect}});|
        logger.debug("script: #{script}")
        html += _script_document_ready(script)
      end
    end
    html.html_safe    
  end

  def version
    "Version #{Okvalue::VERSION}"
  end

  def thumbnail(image, action)
    logger.debug("delete_action: #{action}")
    html = %Q|<div style="position: relative; float: left; width:#{image.width}px; height: #{image.height}px; margin-left: 5px">|
    html += link_to(image_tag(image.avatar.url(:thumb), :class => 'thumbnail'), image.avatar.url(:original), :target => "_blank")
    html += %Q|<div style="position: absolute; top: 0px; left:95%;">|
    html += link_to(t('x'), action, :method => :delete, :data => { :confirm => t('confirm_delete') }, :remote => true, :class => 'delete_x', :title => t('delete'))
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

  def noattachment?(item)
    logger.debug("noattachment? item: #{item}")
    if item.respond_to? :attachment
      if item.attachment.nil? || item.attachment.empty?
        logger.debug("noattachment")
        return noattachment
      end
    else
      raise "Internal Error #{item.class}"
    end
    return ""
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

  def noimage
    html = %Q|<img src="/assets/noimage.jpg" width="50px" height="50px" />|
    html.html_safe
  end
  
  def noattachment
    html = %Q|<img src="/assets/noattachment.jpg" width="50px" height="50px" />|
    html.html_safe
  end
  
  def widget(id,w,h,body,style=nil,title=nil)
    if w.nil? && h.nil?
      html = %Q|<div class="_widget" id="widget_#{id}" style="#{style}">|
    elsif h.nil?
      html = %Q|<div class="_widget" id="widget_#{id}" style="width:#{w}px;#{style}">|
    else
      html = %Q|<div class="_widget" id="widget_#{id}" style="width:#{w}px;height:#{h};#{style}">|
    end
    html += %Q|<div class="_widget_head" style="width:#{w}px;float:right"><span class="label">#{title}</span><div class="_widget_head_window">|
    html += %Q|<a href="#" title=#{t(:minimize)} id="widget_#{id}_min"><i class="icon-resize-small icon-white"></i></a>|
    html += %Q|<a href="#" title=#{t(:maximize)} id="widget_#{id}_max"><i class="icon-fullscreen icon-white"></i></a>|
    html += "</div></div>"
    html += %Q|<div class="_widget_body" id="widget_body_#{id}" style="height:#{h}px">#{body}</div>|
    html += "</div>"
    script = %Q|$('\#widget_#{id}_min').click(function(){$('\#widget_body_#{id}').hide('slow');return false;});|
    script += %Q|$('\#widget_#{id}_max').click(function(){$('\#widget_body_#{id}').show('slow');return false;});|
    html += _script(script)
    html.html_safe
  end
  
  def link_to_with_icon(t,h,c,s,i)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def link_to_with_icon_with_id(t,h,c,s,d,i)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" id="#{d}"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def link_to_with_icon_remote(t,h,c,s,i)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" rel="noffollow" data-remote="true" data-method="post"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def show_alert
    html = ""
    if alert.present?
      html = %Q|<div class="alert alert-block"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{alert}</h4></div>|
    end
    html.html_safe
  end
  
  def show_alert_message(message)
    html = %Q|<div class="alert alert-block"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{message}</h4></div>|
    html.html_safe
  end
  
  def show_notice
    html = ""
    if notice.present?
      html = %Q|<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{notice}</h4></div>|
    end
    html.html_safe
  end

  def _post(url, params)
    html = %Q|$.ajax({url:'| + url + %Q|',type:'POST',timeout:#{Okvalue::AJAX_TIMEOUT},tryCount:0,retryLimit:#{Okvalue::AJAX_RETRY},data:{| + params + %Q|}}).success(function() {|
    if Okbrisbane::Application.config.ok_debug
    html += %Q|console.log("ajax success");|
    end
    html += %Q|}).complete(function(){|
    if Okbrisbane::Application.config.ok_debug
    html += %Q|console.log("ajax complete");|
    end
    html += %Q|}).error(function(xhr, textStatus, errorThrown ) {
        if (textStatus == 'timeout') {
            this.tryCount++;
            if (this.tryCount <= this.retryLimit) {
                //try again
                $.ajax(this);
                return;
            }            
            return;
        }
        if (xhr.status == 500) {
            //handle error
        } else {
            //handle error
        }
    });|
    html.html_safe
  end

end
