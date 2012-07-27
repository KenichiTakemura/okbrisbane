class Accommodation < Post

  HOTEL = "Hotel"
  MOTEL = "Motel"
  APARTMENT = "Self_Catering_Apartments"
  COTTAGE = "Cottages_Cabins_Houses"
  BACKPACKER = "Backpacker_Hostel"
  B_AND_B_GUEST = "B_AND_B_Guest_House"
  CARAVAN_PARK = "Tourist_Caravan_Park"
  FARMSTAY = "Farmstay"
  LODGE = "Lodge"
  PUB_ACCOMMODATION = "Pub_Accommodation"

  ROOM_HOTEL = "room_hotel"
  ROOM_STUDIO = "room_studio"
  ROOM_1BED = "room_1bed"
  ROOM_2BED = "room_2bed"
  ROOM_3PLUSBED = "room_3plusbed"

  # attr_accessible
  attr_accessible :price
  attr_accessible :room_type
  validates_presence_of :price, :message => I18n.t('must_be_filled')
  validates_numericality_of :price, :only_integer => false, :greater_than => 0, :message => I18n.t('must_be_numbers')
  validates_inclusion_of :category, :in => [HOTEL,MOTEL,APARTMENT,COTTAGE,BACKPACKER,B_AND_B_GUEST,CARAVAN_PARK,FARMSTAY,LODGE,PUB_ACCOMMODATION], :message => I18n.t('must_be_selected')
  validates_inclusion_of :room_type, :in => [ROOM_HOTEL,ROOM_STUDIO,ROOM_1BED,ROOM_2BED,ROOM_3PLUSBED], :message => I18n.t('must_be_selected')

  def category_list
    [[I18n.t("#{HOTEL}"),HOTEL],
      [I18n.t("#{MOTEL}"),MOTEL],
      [I18n.t("#{APARTMENT}"),APARTMENT],
      [I18n.t("#{COTTAGE}"),COTTAGE],
      [I18n.t("#{BACKPACKER}"),BACKPACKER],
      [I18n.t("#{B_AND_B_GUEST}"),B_AND_B_GUEST],
      [I18n.t("#{CARAVAN_PARK}"),CARAVAN_PARK],
      [I18n.t("#{FARMSTAY}"),FARMSTAY],
      [I18n.t("#{LODGE}"),LODGE],
      [I18n.t("#{PUB_ACCOMMODATION}"),PUB_ACCOMMODATION]]
  end

  def room_type_list
    [[I18n.t("#{ROOM_HOTEL}"),ROOM_HOTEL],
      [I18n.t("#{ROOM_STUDIO}"),ROOM_STUDIO],
      [I18n.t("#{ROOM_1BED}"),ROOM_1BED],
      [I18n.t("#{ROOM_2BED}"),ROOM_2BED],
      [I18n.t("#{ROOM_3PLUSBED}"),ROOM_3PLUSBED]]
  end

end