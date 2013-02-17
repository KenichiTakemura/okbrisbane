class S::SmartsController < S::SmartApplicationController
   
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def term
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
