class QuickLink < Cachable
  attr_accessible :name, :link_to, :sort_key
  scope :links, select(:name).select(:link_to)
  
  validates_presence_of :name
  validates_presence_of :link_to
  validates_format_of :link_to, :with => URI::regexp(%w(http https)), :message => I18n.t("invalid_url"), :if => Proc.new { |l| !l.link_to.empty? }
  validates_numericality_of :sort_key, :only_integer => true, :greater_than_or_equal_to => 1
  # pagination
  default_scope :order => 'sort_key ASC'
  paginates_per 100
end
