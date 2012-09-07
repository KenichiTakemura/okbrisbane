class PostSearch < ActiveRecord::Base

  SearchCond = Hash.new
  SearchCond[:time_by_day_1] = :post_search_by_time_1
  SearchCond[:time_by_day_2] = :post_search_by_time_2
  SearchCond[:time_by_day_3] = :post_search_by_time_3
  SearchCond[:time_by_day_4] = :post_search_by_time_4
  SearchCond[:time_by_day_5] = :post_search_by_time_5
  SearchCond[:time_by_day_6] = :post_search_by_time_6
  SearchCond[:time_by_week_1] = :post_search_by_time_7
  SearchCond[:time_by_week_2] = :post_search_by_time_8
  SearchCond[:time_by_week_3] = :post_search_by_time_9
  SearchCond[:time_by_week_4] = :post_search_by_time_10
  
  belongs_to :searchable, :polymorphic => true
  
  attr_accessible :okpage, :category, :keyword, :price, :image, :attachment, :time_by
  
  after_initialize :set_default

  def set_default
  end
  
  def set_user(user)
    update_attribute(:searchable, user)
  end
  
  def to_s
    "id: #{id} okpage: #{okpage} category: #{category} keyword: #{keyword} price: #{price} image: #{image} attach: #{attachment} time_by: #{time_by}"
  end
  
  def condition_empty?
    category.empty? && keyword.empty? && image.nil? && attachment.nil? && time_by.nil?
  end
  
  def has_category?
    !category.nil? && !category.empty? 
  end
  
  def has_keyword?
    !keyword.nil? && !keyword.empty? 
  end
  
  def has_image?
    !image.nil?
  end
  
  def has_attachment?
    !attachment.nil?
  end
  
  def has_time_by?
    !time_by.nil? && !time_by.empty?
  end
  
end
