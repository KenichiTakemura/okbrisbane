module Sponsor

  def self.dec(d)
    Common.decrypt_data(d)  
  end
  
  def self.enc(d)
    Common.encrypt_data(d.to_s)
  end
  
  def self.param_c(v)
    Rails.logger.debug("param_v v: #{v}")
    d = dec(v)
    Rails.logger.debug("param_v d: #{d}")
    p =  d.split(SP)[1]
    Rails.logger.debug("param_v p: #{p}")
    p
  end

  def self.param_to_s(p)
    d = dec(p)
    Rails.logger.debug("okpage_p d: #{d}")
    d
  end
  
  def self.param_to_i(p)
    d = dec(p).to_i
    Rails.logger.debug("okpage_p d: #{d}")
    d
  end
  
  def self.param_enc(e)
    enc(e).chop if e.present?
  end
  
  def self.client_link(client)
    enc("#{Common.current_time.to_i}#{SP}#{client}").chop
  end

  def self.sponsor_link_to(client, image)
    %Q|/sponsors?c=| + client_link(client) + "&i=" + param_enc(image)
  end

  private
  
  SP = "+"
  
end