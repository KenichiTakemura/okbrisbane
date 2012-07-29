class Immigration < Post

  FOR_IMMIGRATION = "for_immigration"
  
  # attr_accessible
  validates_inclusion_of :category, :in => [FOR_IMMIGRATION], :message => I18n.t('must_be_selected')

  def category_list
    [[I18n.t("#{FOR_IMMIGRATION}"),FOR_IMMIGRATION]
    ]
  end
  
end