class Tax < Post

  FOR_BUSINESS = "for_business"
  FOR_TAX_RETURN = "for_tax_return"
  
  # attr_accessible
  validates_inclusion_of :category, :in => [FOR_BUSINESS,FOR_TAX_RETURN], :message => I18n.t('must_be_selected')

  def category_list
    [[I18n.t("#{FOR_BUSINESS}"),FOR_BUSINESS],
    [I18n.t("#{FOR_TAX_RETURN}"),FOR_TAX_RETURN]
    ]
  end
  
end
