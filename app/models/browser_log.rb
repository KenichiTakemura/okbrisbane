class BrowserLog < ActiveRecord::Base
  # attr_accessible :title, :body
  def to_s
    "#{day} #{pc_other} #{pc_sf} #{pc_ch} #{pc_ff} #{pc_op} #{pc_ie} #{mo_other} #{mo_sf} #{mo_ch} #{mo_ff} #{mo_op} #{mo_ie}"
  end
end
