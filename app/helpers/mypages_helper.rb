module MypagesHelper

  def mypage_list(post)
    html = %Q|
    <tr class="okboard_list_body #{cycle("odd", "even")}">
          <td>#{t(post.class)}</td>
          <td>#{t(post.category)}</td>
          <td>#{_truncate_with_length(post.subject, 35)}</td>
          <td>#{post.postedDate}</td>
          <td>#{post.validDate}</td>
          <td>|
          if post.has_image?
            html += image_tag("common/IconData2.gif") + "#{job.image.size}"
          end
          html += "</td><td>"
          if post.has_attachment?
            html += image_tag("common/IconData2.gif") + "#{job.attachment.size}"
          end
          html += "</td><td>#{post.comment.size}</td><td>"
          html += "#{post.comment_email}</td></tr>"
          html.html_safe
  end
end
