class ThumbnailableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.instance_of? BusinessProfileImage
      unless record.thumbnailable?
        record.errors.add I18n.t("business_profile_image"), I18n.t("has_invalid_content_type")
      end
    elsif record.instance_of? ClientImage
      unless record.flash_thumbnailable?
        record.errors.add I18n.t("client_banner_image"), I18n.t("has_invalid_content_type")
      end
    elsif record.instance_of? Image
      unless record.thumbnailable?
        record.errors.add I18n.t("image"), I18n.t("has_invalid_content_type")
      end
    elsif record.instance_of? Attachment
      unless record.attachmentable?
        record.errors.add I18n.t("image"), I18n.t("has_invalid_content_type")
      end
    else
      raise "Instance error: #{record.name}" 
    end
  end
end
