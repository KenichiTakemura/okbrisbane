class ImagesController < OkController

  before_filter :authenticate_user!
  
  def index
    write_at = params[:write_at]
    @images = Image.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, write_at)
    respond_to do |format|
      format.js
    end
  end

  def create
    #  Parameters: {"remotipart_submitted"=>"true", "X-Http-Accept"=>"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01", "authenticity_token"=>"fYYDmz71XBiIpKpyYhZMeJJWF+4eurM8y318ezjcRps=", "utf8"=>"✓", "X-Requested-With"=>"IFrame", "image"=>{"something"=>"", "image"=>#<ActionDispatch::Http::UploadedFile:0x7f7137bb33e8 @content_type="text/plain", @original_filename="ozjapanese.txt", @tempfile=#<File:/tmp/RackMultipart20121104-10514-ytf10w-0>, @headers="Content-Disposition: form-data; name=\"image[image]\"; filename=\"ozjapanese.txt\"\r\nContent-Type: text/plain\r\n">}}
    logger.debug("create upload_image")
    param = params[:image]
    something = param[:something]
    write_at = param[:write_at]
    @image = Image.new(:avatar => param[:image])
    logger.debug("something: #{something} write_at: #{write_at}")
    logger.debug("image #{@image}")
    begin
      if @image.thumbnailable?
        logger.debug("image will be saved")
        @image.something = something
        @image.write_at = write_at
        if @image.save
          @image.attached_by(current_user)
          logger.debug("image saved. #{@image}")
          flash[:notice] = I18n.t("successfully_uploaded")
        else
          message = @image.errors.full_messages.map
          logger.error("image failed to save. #{message}")
          flash[:alert] = I18n.t("failed_to_upload")
        end
      else
        logger.warn("image not thumbnailable #{@image.errors.full_messages}")
        flash[:alert] = I18n.t("invalid_file_extention")
      end
      @images = Image.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, write_at)
    rescue Exception => e
      logger.error("something wrong e => #{$!}")
      flash[:alert] = I18n.t("failed_to_upload")
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    logger.debug("delete_image")
    begin
      image = Image.find(params[:id])
      write_at = image.write_at
      flash[:notice] = I18n.t("successfully_deleted")
      image.destroy
    rescue Exception => e
      logger.error("something wrong e => #{$!}")
      flash[:alert] = I18n.t("failed_to_delete")
    end
    @images = Image.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, write_at)
  end
  
end
