class MotorVehicle < Post
    
  Categories = Hash.new
  Categories[:new_car] = "new_car"
  Categories[:used_car] = "used_car"
  
  def category_list()
    list = Array.new
    Categories.each do |key,value|
      list.push([I18n.t(value),value])
    end
    list
  end
  
  def getCategory(key)
    Categories[key]
  end
    
  attr_accessible :price 
  validates_presence_of :price, :message => I18n.t('must_be_filled')
  validates_presence_of :price, :message => I18n.t('must_be_filled')

end