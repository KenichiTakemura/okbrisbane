class SponsorsController < ApplicationController

  def show
    raise "Bad Request" if !params[:c].present?
    raise "Bad Request" if !params[:i].present?
    client = Sponsor.param_c(params[:c])
    client_image = ClientImage.find(Sponsor.param_to_i(params[:i]))
    logger.info("Sponsor Clicked: #{client} with #{client_image}")
    ActiveRecord::Base.transaction do
      client_image.click
    end
    if client_image.linkable?
      redirect_to client_image.link and return
    end
    if client_image.attached.has_url?
      redirect_to client_image.attached.business_url and return
    end
    @okpage = :p_sponsor
    @business_client = BusinessClient.find(client_image.attached_id)
    respond_to do |format|
      format.html { render :template => "okboards/index" }
    end
  end
  
  def show_ok
    raise "Bad Request" if !params[:t].present?
    contact_type = params[:t]
    @ok = BusinessClient.okbrisbane.first
    logger.debug("Sponsor_OK: #{@ok}")
    @okpage = :p_sponsor
    @contact = Contact.new
    @contact.contact_type = contact_type
    if current_user
      @contact.user_name = current_user.user_name
      @contact.email = current_user.email
    end
    respond_to do |format|
      format.html { render :template => "okboards/index" }
    end
  end
  
  def thank_you
        @ok = BusinessClient.okbrisbane.first
        @okpage = :p_sponsor
        respond_to do |format|
          format.html { render :template => "okboards/thank_you" }
        end
  end
end