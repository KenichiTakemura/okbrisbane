class AttachablesController < OkController

  before_filter :authenticate_user!
  
  @@model = nil
  
  def _index
    write_at = params[:write_at]
    @@model.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, write_at)
  end

  def _create
    #  Parameters: {"remotipart_submitted"=>"true", "X-Http-Accept"=>"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01", "authenticity_token"=>"fYYDmz71XBiIpKpyYhZMeJJWF+4eurM8y318ezjcRps=", "utf8"=>"✓", "X-Requested-With"=>"IFrame", "image"=>{"something"=>"", "image"=>#<ActionDispatch::Http::UploadedFile:0x7f7137bb33e8 @content_type="text/plain", @original_filename="ozjapanese.txt", @tempfile=#<File:/tmp/RackMultipart20121104-10514-ytf10w-0>, @headers="Content-Disposition: form-data; name=\"image[image]\"; filename=\"ozjapanese.txt\"\r\nContent-Type: text/plain\r\n">}}
    if params[:image].present?
      param = params[:image]
      media = @@model.new(:avatar => param[:image])
    elsif params[:attachment].present?
      param = params[:attachment]
      media = @@model.new(:avatar => param[:attachment])
    end
    write_at = param[:write_at]
    something = param[:something].presence || ""
    
    logger.debug("something: #{something} write_at: #{write_at}")
    begin
      logger.debug("media: #{media}")
      if (media.instance_of?(Image) && media.thumbnailable?) || media.instance_of?(Attachment)
        logger.debug("media will be saved")
        media.something = something if media.respond_to? :something
        media.write_at = write_at
        if media.save
          media.attached_by_user(current_user)
          logger.debug("media saved. #{media}")
          flash[:notice] = I18n.t("successfully_uploaded")
        else
          message = media.errors.full_messages.map
          logger.error("media failed to save. #{message}")
          flash[:alert] = I18n.t("failed_to_upload")
        end
      else
        logger.warn("media not thumbnailable #{media.errors.full_messages}")
        flash[:alert] = I18n.t("invalid_file_extention")
      end
      @@model.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, write_at)
    rescue Exception => e
      logger.error("something wrong e => #{$!}")
      flash[:alert] = I18n.t("failed_to_upload")
    end
  end
  
  def _destroy
    begin
      media = @@model.find(params[:id])
      write_at = media.write_at
      flash[:notice] = I18n.t("successfully_deleted")
      media.destroy
    rescue Exception => e
      logger.error("something wrong e => #{$!}")
      flash[:alert] = I18n.t("failed_to_delete")
    end
    @@model.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, write_at)
  end
  
end
