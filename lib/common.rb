module Common
  def self.date_format(date)
    date.strftime("%Y-%m-%d") if date
  end

  require 'openssl'
  
  def self.encrypt(data)
    cipher = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
    cipher.encrypt
    cipher.pkcs5_keyivgen("okbrisbane",OpenSSL::Random.random_bytes(8))
    e_data = cipher.update(data) + cipher.final
    encrypted = e_data.unpack("H*").to_s
  rescue => exception
    puts exception.backtrace
    false
  end

  def self.decrypt(bbb, solt = 'solt')
    dec = OpenSSL::Cipher::Cipher.new('aes256') 
    dec.decrypt 
    dec.pkcs5_keyivgen(solt)
    (dec.update(Array.new([bbb]).pack("H*")) + dec.final)
  rescue  
    false 
  end 

  def self.hash(ccc)
    OpenSSL::Digest::SHA1.new(ccc).to_s
  end

end
