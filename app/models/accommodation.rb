class Accommodation < Post

  # override
  def topfeedable?
    true
  end
  
  Categories = Hash.new
  Categories[:hotel] = "Hotel"
  Categories[:motel] = "Motel"
  Categories[:apartment] = "Self_Catering_Apartments"
  Categories[:cottage] = "Cottages_Cabins_Houses"
  Categories[:backpacker] = "Backpacker_Hostel"
  Categories[:caravan_park] = "Tourist_Caravan_Park"
  Categories[:farmstay] = "Farmstay"
  
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
  
  ROOM_HOTEL = "room_hotel"
  ROOM_STUDIO = "room_studio"
  ROOM_1BED = "room_1bed"
  ROOM_2BED = "room_2bed"
  ROOM_3PLUSBED = "room_3plusbed"

  # attr_accessible
  attr_accessible :price
  attr_accessible :room_type
  validates_presence_of :price, :message => I18n.t('must_be_filled')
  validates_inclusion_of :room_type, :in => [ROOM_HOTEL,ROOM_STUDIO,ROOM_1BED,ROOM_2BED,ROOM_3PLUSBED], :message => I18n.t('must_be_selected')

  def room_type_list
    [[I18n.t("#{ROOM_HOTEL}"),ROOM_HOTEL],
      [I18n.t("#{ROOM_STUDIO}"),ROOM_STUDIO],
      [I18n.t("#{ROOM_1BED}"),ROOM_1BED],
      [I18n.t("#{ROOM_2BED}"),ROOM_2BED],
      [I18n.t("#{ROOM_3PLUSBED}"),ROOM_3PLUSBED]]
  end

end