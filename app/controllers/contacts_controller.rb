class ContactsController < OkController

  before_filter :filter

  def filter
    
  end

  def create
    @contact = Contact.new(params[:contact])
    ActiveRecord::Base.transaction do
      if @contact.save
        @contact.set_user(current_user)
        ContactMailer.send_contact_to_admin(@contact).deliver
        ContactMailer.send_contact_to_user(@contact).deliver
        respond_to do |format|
          format.html { redirect_to thank_you_sponsors_path  }
          format.json { render :json => @contact, :status => :created }
        end
      else
        flash[:warning] = I18n.t("failed_to_create")
        @contact.errors.full_messages.each do |msg|
          logger.warn("@post.errors: #{msg}")
        end
        @okpage = :p_sponsor
        @ok = BusinessClient.okbrisbane.first
        respond_to do |format|
          format.html { render :template => "okboards/index" }
          format.json { render :json => @contact.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  protected

end