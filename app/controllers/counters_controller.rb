class CountersController < ActionController::Base
  
  before_filter :filter
  
  def filter
    raise NotFoundError.new unless request.remote_ip == "127.0.0.1"
  end

  def batch
    begin
      Counter.instance.flash_hit
      render :text => "OK", :status => 200
    rescue
      render :text => "NG", :status => 500
    end
  end
    
end