# -*- coding: utf-8 -*-
module WeatherConfig
  
  AUSCityOrderList = [:brisbane, :sydney, :melbourne,  :canberra, :hobart, :adelaide, :perth, :darwin]
  AUSCityMap = Common.new_orderd_hash
  AUSCityMap[:sydney] = "http://www.weather.com.au/nsw/sydney"
  AUSCityMap[:melbourne] = "http://www.weather.com.au/vic/melbourne"
  AUSCityMap[:brisbane] = "http://www.weather.com.au/qld/brisbane"
  AUSCityMap[:canberra] = "http://www.weather.com.au/act/canberra"
  AUSCityMap[:hobart] = "http://www.weather.com.au/tas/hobart"
  AUSCityMap[:adelaide] = "http://www.weather.com.au/sa/adelaide"
  AUSCityMap[:perth] = "http://www.weather.com.au/wa/perth"
  AUSCityMap[:darwin] = "http://www.weather.com.au/nt/darwin"

  AUSCityVisibleMap = Common.new_orderd_hash
  AUSCityVisibleMap[:sydney] = true
  AUSCityVisibleMap[:melbourne] = true
  AUSCityVisibleMap[:brisbane] = true
  AUSCityVisibleMap[:canberra] = true
  AUSCityVisibleMap[:hobart] = true
  AUSCityVisibleMap[:adelaide] = true
  AUSCityVisibleMap[:perth] = false
  AUSCityVisibleMap[:darwin] = true
    
  KORCityOrderList = [:seo,:gwn,:cbk,:cnm,:jbk,:jnm,:gbk,:gnm,:jju]

  KORCityXMLMap = Common.new_orderd_hash
  # 서울·경기도
  KORCityXMLMap[:seo] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109"
  # 강원도
  KORCityXMLMap[:gwn] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=105"
  # 충청북도
  KORCityXMLMap[:cbk] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=131"
  # 충청남도
  KORCityXMLMap[:cnm] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=133"
  # 전라북도
  KORCityXMLMap[:jbk] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=146"
  # 전라남도
  KORCityXMLMap[:jnm] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=156"
  # 경상북도
  KORCityXMLMap[:gbk] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=143"
  # 경상남도
  KORCityXMLMap[:gnm] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=159"
  # 제주특별자치도
  KORCityXMLMap[:jju] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=184"
  
  KORCityMap = Common.new_orderd_hash
  KORCityMap[:seo] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  KORCityMap[:gwn] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  KORCityMap[:cbk] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  KORCityMap[:cnm] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  KORCityMap[:jbk] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  KORCityMap[:jnm] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  KORCityMap[:gbk] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  KORCityMap[:gnm] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  KORCityMap[:jju] = "http://www.kma.go.kr/weather/forecast/mid-term_01.jsp"
  
  KORCityVisibleMap = Common.new_orderd_hash
  KORCityVisibleMap[:seo] = true
  KORCityVisibleMap[:gwn] = true
  KORCityVisibleMap[:cbk] = true
  KORCityVisibleMap[:cnm] = true
  KORCityVisibleMap[:jbk] = true
  KORCityVisibleMap[:jnm] = true
  KORCityVisibleMap[:gbk] = true
  KORCityVisibleMap[:gnm] = true
  KORCityVisibleMap[:jju] = true

  
  
    
  def self.getAUData
    require 'nokogiri'
    require 'open-uri'

    infobox = Array.new

    doc = Nokogiri::HTML(open("tmp/IDA00100.html"))

    doc.search('td').each do |link|
      puts link.content
    end

  end

  
end
