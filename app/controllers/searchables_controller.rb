class SearchablesController < ApplicationController
  
  QUERY_LIMIT = 8
  
  before_filter :_query, :only => "query"
  before_filter :_search, :only => "search"
  
  def _query
    @@query = params[:query]
  end
  
  def _search
    @@key = params[:key]
  end
end
