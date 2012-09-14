module Common
  def self.date_format(date)
    date_l = date.utc? ? date.localtime : date
    date_l.strftime("%Y-%m-%d")
  end
  
  def self.date_format_md(date)
    date_l = date.utc? ? date.localtime : date
    date_l.localtime.strftime("%m-%d")
  end

  def self.date_format_ymdhms(date)
    date_l = date.utc? ? date.localtime : date
    date_l.strftime("%Y-%m-%d %H:%M.%S")
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
  
end
