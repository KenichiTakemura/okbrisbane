class MotorVehicle < Post

  Category[:new_car] = "new_car"
  Category[:used_car] = "used_car"
  # attr_accessible
  attr_accessible :price 
  validates_presence_of :price, :message => I18n.t('must_be_filled')
  validates_numericality_of :price, :only_integer => false, :greater_than => 0, :message => I18n.t('must_be_numbers')

end