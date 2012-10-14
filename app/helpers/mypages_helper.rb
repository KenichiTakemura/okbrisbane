module MypagesHelper

  def mypage_list(post)
    html = %Q|
          <tr class="okboard_list_body #{cycle("odd", "even")}">
          <td>#{t(post.class)}</td>
          <td>#{t(post.category)}</td>
          <td>#{link_to_with_icon(_truncate_with_length(post.subject, 35),Okboard.okboard_link_with_id(Style.m2s(post.class.to_s), post.id),"","","icon-play")}</td>
          <td>#{post.postedDate}</td>
          <td>#{post.validDate}</td>
          <td>|
          #if post.has_image?
          #  html += image_tag("common/IconData2.gif") + "#{post.image.size}"
          #end
          html += "</td><td>"
          if post.has_attachment?
            html += image_tag("common/IconData2.gif") + "#{post.attachment.size}"
          end
          html += "</td><td>"
          if post.comment.present? 
            html += %Q|<a href="#commentModal_#{post.class}_#{post.id}" id="a_commentModal_#{post.class}_#{post.id}" role="button" class="btn" data-toggle="modal"><i class="icon-comment"></i>#{post.comment.size}</a>|
          else
            html += %Q|<i class="icon-comment"></i>#{post.comment.size}|
          end
          #html += "</td><td>"
          #if post.comment_email
          #  html += %Q|<i class="icon-check"></i>|
          #end
          html += "</td></tr>"
          if post.comment.present? 
            html += %Q|<div class="modal hide fade" id="commentModal_#{post.class}_#{post.id}" tabindex="-1" role="dialog" aria-labelledby="commentModalLabel_#{post.class}_#{post.id}" aria-hidden="true">|
            html += %Q|<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>|
            html += %Q|<h3 id="commentModalLabel_#{post.class}_#{post.id}">#{t(:comment)}</h3></div>|
            html += %Q|<div class="modal-body" id="modal-body_#{post.class}_#{post.id}">|
            html += %Q|#{image_tag("common/ajax_loader_1.gif")}|
            html += %Q|</div><div class="modal-footer">|
            html += %Q|<a href="#{Okboard.okboard_link_with_id(Style.m2s(post.class.to_s), post.id, nil) << "#new_comment"}" class="btn" aria-hidden="true">#{t(:comment)} #{t(:add)}</a>|
            html += %Q|<button class="btn" data-dismiss="modal" aria-hidden="true">#{t(:close)}</button></div></div>|
            html += _script(%Q|$('\#a_commentModal_#{post.class}_#{post.id}').click(function(){$.post('| + post_for_comments_path + %Q|', {v: '#{Okboard.okpage_v(Style.m2s(post.class.to_s))}', d: '#{Okboard.param_enc(post.id)}'})});|)
          end
          html.html_safe
  end

end
