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
      show_alert(msg)
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
    if post.present?
      if post.posted_by_type.eql? "Admin"
        return t('admin')
      elsif post.posted_by.present?
        return post.posted_by.name 
      end
    end
    t("unknown_user")
  end
  
  def comment_author(comment)
    if comment.present? && comment.commented_by.present?
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
  
  def local_signin?
    SystemConfig.instance.local_signin
  end
  
  def facebook_signin?
    SystemConfig.instance.facebook_signin
  end
  
  def google_signin?
    SystemConfig.instance.google_signin
  end
  
  def naver_signin?
    SystemConfig.instance.naver_signin
  end
  
  def twitter_signin?
    SystemConfig.instance.twitter_signin
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
      html += %Q|<div class="" id="banner_description_#{div_id}"><p class='description_content'>#{link_to_with_icon(contact,show_ok_sponsors_path(:t => Okvalue::CONTACT_BANNER),"btn btn-primary","","icon-info-sign icon-white","")}#{}</p></div>|
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
          html += %Q|<div id="#{div_id}_#{Common.unique_token}">|
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
    sc = Style.get_style_class(Style.pagename(b.page_id), Style.sectionname(b.section_id),b.position_id)
    if request.host =~ /admin.okbrisbane/
      html = image_tag(image.original_image, :class => sc, :style => style, :size => "#{b.img_width}x#{b.img_height}")
      Rails.logger.debug("one_image html : #{html}")
    else
      if banner_clickable?
        html = link_to(image_tag(image.original_image, :class => sc, :style => "width:#{b.img_width}px;height:#{b.img_height}px;#{style}"), Sponsor.sponsor_link_to(image.attached_id, image.id))
      else
        html = image_tag(image.original_image, :class => sc, :style => style, :alt => "Loading...", :size => "#{b.img_width}x#{b.img_height}")
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
    return "" if b.is_disabled && !(request.host =~ /admin.okbrisbane/)
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
    return "" if b.is_disabled && !(request.host =~ /admin.okbrisbane/)
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
    if length.present?
      html = %Q|<span title="#{expression}">#{truncate(expression, :length => length)}</span>|
      html.html_safe
    else
      _truncate(expression)
    end
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

end
