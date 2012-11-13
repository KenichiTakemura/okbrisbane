module QuickLinks

  LINKS = Common.new_orderd_hash
  LINKS[:immigration] = ["link.immigration","http://www.immi.gov.au/",true]
  LINKS[:ato] = ["link.ato","http://www.ato.gov.au/",true]
  LINKS[:bcc] = ["link.bcc","http://www.brisbane.qld.gov.au/",true]
  LINKS[:qr] = ["link.qr","http://translink.com.au/",true]
  LINKS[:weather_warning] = ["link.weather_warning","http://www.bom.gov.au/qld/",true]
  LINKS[:brisbane_airport] = ["link.brisbane_airport","http://www.bne.com.au/",true]
  LINKS[:asian_police] = ["link.asian_police","http://www.police.qld.gov.au/programs/community/asu/contact.htm",true]
  
  def self.links
    LINKS.clone
  end
  
end