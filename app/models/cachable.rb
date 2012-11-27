class Cachable < ActiveRecord::Base
  
  self.abstract_class = true
  
  def self.fetch(id)
    logger.debug("fetch called #{self.name}/#{id}")
    o = Rails.cache.fetch("#{self.name}/#{id}")
    logger.debug("fetch #{o}")
    o || find(id)
  end
  
  after_save :_after_save
  after_destroy :_after_destroy
  
  def _after_save
    logger.debug("after_save called #{self.class}/#{id}")
    Rails.cache.write("#{self.class}/#{id}", self)
    cache = Rails.cache.fetch("#{self.class}/#{id}")
    logger.debug("cache: #{cache}")
  end

  def _after_destroy
    logger.debug("after_destroy called")
    Rails.cache.delete("#{self.class}/#{id}")
  end

end
