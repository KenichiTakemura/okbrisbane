module Common
  def self.date_format(date)
    if date.present?
      date_l = date.utc? ? date.localtime : date
      date_l.strftime("%Y-%m-%d")
    end
  end

  def self.date_format_md(date)
    if date.present?
      date_l = date.utc? ? date.localtime : date
      date_l.localtime.strftime("%m-%d")
    end
  end
  
  def self.date_format_ymdhm(date)
    if date.present?
      date_l = date.utc? ? date.localtime : date
      date_l.strftime("%Y-%m-%d %H:%M")
    end
  end

  def self.date_format_ymdhms(date)
    if date.present?
      date_l = date.utc? ? date.localtime : date
      date_l.strftime("%Y-%m-%d %H:%M.%S")
    end
  end

  def self.today
    current_time.strftime("%Y-%m-%d")
  end

  # Time must be got from this method
  def self.current_time
    Time.now.localtime
  end

  def self.this_month
    current_time.strftime("%Y-%m")
  end

  def self.days_ago(x)
    (current_time - x.days)
  end

  def self.new_orderd_hash
    ActiveSupport::OrderedHash.new
  end

  def self.uniqe_token
    rand(36**8).to_s(36)
  end

  def self.random_index(a, b)
    return 0 if a.size >= b
    while true
      v = rand(b)
      return v if !a.include?(v)
    end
  end

  def self.hash(ccc)
    OpenSSL::Digest::SHA1.new(ccc).to_s
  end

  def self.decrypt_data(data)
    require 'encryptor'
    key = 'okbrisbane_rocks2012!'
    Base64.decode64(data.tr('-_','+/')).decrypt(:key => key)
  rescue
    false
    end

  def self.encrypt_data(data)
    require 'encryptor'
    key = 'okbrisbane_rocks2012!'
    Base64.encode64(Encryptor.encrypt(data, :key => key)).tr('+/','-_')
    rescue
    false
  end

  
  def self.browser_detection(request)
    result = request.env['HTTP_USER_AGENT']
    browser_compatible = Okvalue::NOT_DETECTED
    if result =~ /Safari/
      unless result =~ /Chrome/
        version = result.split('Version/')[1].split(' ').first.split('.').first
        browser_compatible = Okvalue::Safari
      else
        version = result.split('Chrome/')[1].split(' ').first.split('.').first
        browser_compatible = Okvalue::Chrome
      end
    elsif result =~ /Firefox/
      version = result.split('Firefox/')[1].split('.').first
      browser_compatible = Okvalue::Firefox
    elsif result =~ /Opera/
      version = result.split('Version/')[1].split('.').first
      browser_compatible = Okvalue::Opera
    elsif result =~ /MSIE/
      version = result.split('MSIE')[1].split(' ').first
      browser_compatible = Okvalue::MSIE
    end
    browser_compatible
  end

end
