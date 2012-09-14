class PostSearch < ActiveRecord::Base

  SearchCond = Common.new_orderd_hash
  SearchCond[:post_search_by_time_0] = :time_by_day_0
  SearchCond[:post_search_by_time_1] = :time_by_day_1
  SearchCond[:post_search_by_time_2] = :time_by_day_2
  SearchCond[:post_search_by_time_3] = :time_by_day_3
  SearchCond[:post_search_by_time_4] = :time_by_day_4
  SearchCond[:post_search_by_time_5] = :time_by_day_5
  SearchCond[:post_search_by_time_6] = :time_by_day_6
  SearchCond[:post_search_by_time_7] = :time_by_week_1
  SearchCond[:post_search_by_time_8] = :time_by_week_2
  SearchCond[:post_search_by_time_9] = :time_by_week_3
  SearchCond[:post_search_by_time_10] = :time_by_week_4
  SearchCond[:post_search_by_time_11] = :time_by_older
  
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
    !has_category? && !has_keyword? && !has_image? && !has_attachment? && !has_time_by?
  end
  
  def has_category?
    category.present?
  end
  
  def has_keyword?
    keyword.present?
  end
  
  def has_image?
    image.present?
  end
  
  def has_attachment?
    attachment.present?
  end
  
  def has_time_by?
    time_by.present?
  end
  
end
