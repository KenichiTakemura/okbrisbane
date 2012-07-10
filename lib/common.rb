module Common
  def self.date_format(date)
    date.strftime("%Y-%m-%d") if date
  end

end
