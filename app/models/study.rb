class Study < Post

  FOR_STUDY_OVERSEAS = "for_study_overseas"
  FOR_LANGUAGE = "for_language"
  
  # attr_accessible
  validates_inclusion_of :category, :in => [FOR_STUDY_OVERSEAS,FOR_LANGUAGE], :message => I18n.t('must_be_selected')

  def category_list
    [[I18n.t("#{FOR_STUDY_OVERSEAS}"),FOR_STUDY_OVERSEAS],
    [I18n.t("#{FOR_LANGUAGE}"),FOR_LANGUAGE]
    ]
  end
  
end