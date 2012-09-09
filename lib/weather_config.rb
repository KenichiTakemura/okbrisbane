# -*- coding: utf-8 -*-
module WeatherConfig
  
  AUSCityOrderList = [:brisbane, :sydney, :melbourne,  :canberra, :hobart, :adelaide, :perth, :darwin]
  AUSCityMap = Hash.new  
  AUSCityMap[:sydney] = "http://www.weather.com.au/nsw/sydney"
  AUSCityMap[:melbourne] = "http://www.weather.com.au/vic/melbourne"
  AUSCityMap[:brisbane] = "http://www.weather.com.au/qld/brisbane"
  AUSCityMap[:canberra] = "http://www.weather.com.au/act/canberra"
  AUSCityMap[:hobart] = "http://www.weather.com.au/tas/hobart"
  AUSCityMap[:adelaide] = "http://www.weather.com.au/sa/adelaide"
  AUSCityMap[:perth] = "http://www.weather.com.au/wa/perth"
  AUSCityMap[:darwin] = "http://www.weather.com.au/nt/darwin"

  AUSCityVisibleMap = Hash.new
  AUSCityVisibleMap[:sydney] = true
  AUSCityVisibleMap[:melbourne] = true
  AUSCityVisibleMap[:brisbane] = true
  AUSCityVisibleMap[:canberra] = true
  AUSCityVisibleMap[:hobart] = true
  AUSCityVisibleMap[:adelaide] = true
  AUSCityVisibleMap[:perth] = false
  AUSCityVisibleMap[:darwin] = true
    
  KORCityOrderList = [:seo,:ich,:bsn,:cbk,:cnm,:dgu,:djn,:gbk,:ggi,:gju,:gnm,:gwn,:jbk,:jju,:jnm,:usn]
  
  KORCityMap = Hash.new
  KORCityMap[:seo] = "http://www.kma.go.kr/weather/main_all.jsp?stncd=108"
  KORCityMap[:ich] = "http://www.kma.go.kr/weather/main_all.jsp?stncd=112"
    
  KORCityVisibleMap = Hash.new
  KORCityVisibleMap[:seo] = true
  KORCityVisibleMap[:icn] = true
  KORCityVisibleMap[:bcn] = true
  KORCityVisibleMap[:cbk] = true
  KORCityVisibleMap[:cnm] = true
  KORCityVisibleMap[:dgu] = true
  KORCityVisibleMap[:djn] = false
  KORCityVisibleMap[:gbk] = true
  KORCityVisibleMap[:ggi] = false
  KORCityVisibleMap[:gju] = false
  KORCityVisibleMap[:gnm] = false
  KORCityVisibleMap[:gwn] = false
  KORCityVisibleMap[:jbk] = false
  KORCityVisibleMap[:jju] = true
  KORCityVisibleMap[:jnm] = false
  KORCityVisibleMap[:usn] = false
  
end
