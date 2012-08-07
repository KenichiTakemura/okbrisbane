module Common
  def self.date_format(date)
    date.strftime("%Y-%m-%d") if date
  end

  def self.hash(ccc)
    OpenSSL::Digest::SHA1.new(ccc).to_s
  end

  require 'encryptor'
  
  def self.decrypt_data(data)
    key = 'okbrisbane_rocks2012!'
    Base64.decode64(data.tr('-_','+/')).decrypt(:key => key)
    rescue  
      false 
  end
  
  def self.encrypt_data(data)
    key = 'okbrisbane_rocks2012!'
    Base64.encode64(Encryptor.encrypt(data, :key => key)).tr('+/','-_')
    rescue  
      false 
  end
  
end
