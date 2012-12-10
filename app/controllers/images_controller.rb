class ImagesController < AttachablesController

  before_filter :authenticate_user!
  
  @@model = Image
    
  def index
    @images = _index
    respond_to do |format|
      format.js
    end
  end

  def create
    @images = _create
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @images = _destroy
    respond_to do |format|
      format.js
    end
  end
  
end
