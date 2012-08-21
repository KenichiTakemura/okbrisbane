class ThumbnailableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.thumbnailable?
      if record.instance_of? BusinessProfileImage
        record.errors.add I18n.t("business_profile_image"), I18n.t("has_invalid_content_type")
      elsif record.instance_of? Image
        record.errors.add I18n.t("image"), I18n.t("has_invalid_content_type")
      end
    end
  end
end
