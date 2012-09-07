class PostSearchesController < ApplicationController
  def create
    @post_search = PostSearch.new(params[:post_search])
    okpage = @post_search.okpage
    if @post_search.condition_empty?
      logger.info("No Search Condition")
      redirect_to Okboard.okboard_link(okpage) and return
    end
    ActiveRecord::Base.transaction do
      if @post_search.save
        if current_user
          @post_search.set_user(current_user)
        end
        redirect_to Okboard.okboard_link_with_search(okpage, @post_search.id) and return
      else
        redirect_to Okboard.okboard_link(okpage) and return
      end
    end
  end

  def update
    # will create
    @post_search = PostSearch.new(params[:post_search])
    logger.debug("New Search: #{@post_search}")
    okpage = @post_search.okpage
    if @post_search.condition_empty?
      logger.info("No Search Condition")
      redirect_to Okboard.okboard_link(okpage) and return
    end
    ActiveRecord::Base.transaction do
      if @post_search.save
        if current_user
          @post_search.set_user(current_user)
        end
        redirect_to Okboard.okboard_link_with_search(okpage, @post_search.id) and return
      else
        redirect_to Okboard.okboard_link(okpage) and return
      end
    end
  end
end