class BusinessClientsController < SearchablesController

  def query
    clients = BusinessClient.query_by_name(@@query, QUERY_LIMIT)
    result = clients.collect{ |c| c.business_name}
    respond_to do |format|
      format.json { render :json => result }
    end
  end
  
  def search
    if @@key.present?
      @business_clients = BusinessClient.search(@@key, QUERY_LIMIT)
    else
      @business_clients = BusinessClient.order
    end
    respond_to do |format|
      format.js
    end
  end
  
end
