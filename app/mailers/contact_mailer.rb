class ContactMailer < ActionMailer::Base
  default :from => "OKBRISBANE <do_no_reply@okbrisbane.com>"
  
  def send_contact_to_admin(contact)
    to = SystemSetting.first.contact_email
    subject = ""
    case contact.contact_type
    when Okvalue::CONTACT_BANNER
      subject += "[#{t(:contact_banner)}]"
    when Okvalue::CONTACT_GENERAL
      subject += "[#{t(:contact_general)}]"
    when Okvalue::CONTACT_FEEDBACK
      subject += "[#{t(:contact_feedback)}]"
    when Okvalue::CONTACT_ISSUE
      subject += "[#{t(:contact_issue)}]"
    when Okvalue::CONTACT_EXIT
      subject += "[#{t(:contact_exit)}]"
    else
      raise "Bad Contact Type"
    end
    logger.info("email is besing sent to #{to}")
    @contact = contact
    @subject = subject
    mail(:to => to,
         :subject => subject)
  end

  def send_contact_to_user(contact)
    to = contact.email
    logger.info("email is besing sent to #{to}")
    subject = ""
    case contact.contact_type
    when Okvalue::CONTACT_BANNER
      subject += "[#{t(:contact_banner)}]"
    when Okvalue::CONTACT_GENERAL
      subject += "[#{t(:contact_general)}]"
    when Okvalue::CONTACT_FEEDBACK
      subject += "[#{t(:contact_feedback)}]"
    when Okvalue::CONTACT_ISSUE
      subject += "[#{t(:contact_issue)}]"
    when Okvalue::CONTACT_EXIT
      subject += "[#{t(:contact_exit)}]"
    else
      raise "Bad Contact Type"
    end
    @contact = contact
    @subject = subject
    mail(:to => to,
         :subject => t(:confirmation_email))
  end

end