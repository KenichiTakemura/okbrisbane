class MotorVehicle < Post
  
  after_initialize :set_category

  def set_category
    # Category
    Categories[:new_car] = "new_car"
    Categories[:used_car] = "used_car"
  end
    
  attr_accessible :price 
  validates_presence_of :price, :message => I18n.t('must_be_filled')
  validates_numericality_of :price, :only_integer => false, :greater_than => 0, :message => I18n.t('must_be_numbers')

end