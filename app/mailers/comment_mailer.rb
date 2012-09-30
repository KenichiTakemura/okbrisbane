class CommentMailer < ActionMailer::Base
  default :from => "OKBRISBANE <do_no_reply@okbrisbane.com>"
  
  def send_comment_to_author(okpage, post, comment)
    to = post.posted_by.email
    subject = "[OKBRISBANE] " + comment.commented_by.name + " #{t(:has_commented_on_your_post)}"
    logger.info("email is besing sent to #{to}")
    @okpage = okpage
    @post = post
    @comment = comment
    mail(:to => to,
         :subject => subject)
  end

end