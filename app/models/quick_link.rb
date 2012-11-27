class QuickLink < Cachable
  attr_accessible :name, :link_to, :sort_key
  scope :desc, :order => 'sort_key ASC'
  scope :links, select(:name).select(:link_to).desc
end
