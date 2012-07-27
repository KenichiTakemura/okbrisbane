class Law < Post

  FOR_CRIMINAL_ACTION = "for_criminal_action"
  FOR_CONVEYANCING = "for_conveyancing"
  FOR_BUSINESS_BUY_AND_SELL = "for_business_buysing_and_selling"
  FOR_TRAFFIC_ACCIDENT = "for_traffic_accident"
  FOR_ACCIDENT = "for_accident"
  
  # attr_accessible
  validates_inclusion_of :category, :in => [FOR_CRIMINAL_ACTION,FOR_CONVEYANCING,FOR_BUSINESS_BUY_AND_SELL,FOR_TRAFFIC_ACCIDENT,FOR_ACCIDENT], :message => I18n.t('must_be_selected')

  def category_list
    [[I18n.t("#{FOR_CRIMINAL_ACTION}"),FOR_CRIMINAL_ACTION],
    [I18n.t("#{FOR_CONVEYANCING}"),FOR_CONVEYANCING],
    [I18n.t("#{FOR_BUSINESS_BUY_AND_SELL}"),FOR_BUSINESS_BUY_AND_SELL],
    [I18n.t("#{FOR_TRAFFIC_ACCIDENT}"),FOR_TRAFFIC_ACCIDENT],
    [I18n.t("#{FOR_ACCIDENT}"),FOR_ACCIDENT]
    ]
  end
  
end