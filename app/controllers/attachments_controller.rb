class AttachmentsController < AttachablesController

  before_filter :authenticate_user!
  
  @@model = Attachment
    
  def index
    @attachments = _index
    respond_to do |format|
      format.js
    end
  end

  def create
    @attachments = _create
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @attachments = _destroy
    respond_to do |format|
      format.js
    end
  end
  
end
