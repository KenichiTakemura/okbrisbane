module Ajax
  
  AJAX_TIMEOUT = 8000
  AJAX_RETRY = 2
  
  DEBUG = false
  
  def self.get(url, params)
    ajax_call(url, params, "GET")
  end
  
  def self.post(url, params)
    ajax_call(url, params, "POST")
  end
  
  def self.ajax_call(url, params, type)
    html = %Q|$.ajax({url:'| + url + %Q|',type:'#{type}',timeout:#{AJAX_TIMEOUT},tryCount:0,retryLimit:#{AJAX_RETRY},data:{| + params + %Q|}}).success(function() {|
    html += %Q|}).complete(function(){|
    html += %Q|}).error(function(xhr, textStatus, errorThrown ) {
        if (textStatus == 'timeout') {|
    if DEBUG
    html += %Q|console.log("ajax timeout occurred.");|
    end
    html += %Q|this.tryCount++;
            if (this.tryCount <= this.retryLimit) {
                //try again
                $.ajax(this);
                return;
            }            
            return;
        }
        if (xhr.status == 500) {
            //handle error
        } else {
            //handle error
        }
    });|
    html.html_safe
  end
end
