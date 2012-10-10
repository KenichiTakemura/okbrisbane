# -*- coding: utf-8 -*-
module WeatherConfig

  WEATHER_AUS = "ftp2.bom.gov.au"
  WAETHER_AUS_FORECAST = "anon/gen/fwo/IDA00100.dat"
  WAETHER_AUS_FORECAST_TMP = "#{Rails.root}/tmp/IDA00100.dat"
  WEATHER_KOR = "http://www.kma.go.kr/wid/queryDFS.jsp?"

  WEATHER_RETRY = 1

  AUSCityOrderList = [:Brisbane, :Sydney, :Melbourne, :Canberra, :Adelaide, :Perth, :Darwin, :Hobart, ]
  AUSCityMap = Common.new_orderd_hash
  AUSCityMap[:Brisbane] = "http://www.bom.gov.au/qld/forecasts/brisbane.shtml"
  AUSCityMap[:Sydney] = "http://www.bom.gov.au/nsw/forecasts/sydney.shtml"
  AUSCityMap[:Melbourne] = "http://www.bom.gov.au/vic/forecasts/melbourne.shtml"
  AUSCityMap[:Canberra] = "http://www.bom.gov.au/act/forecasts/canberra.shtml"
  AUSCityMap[:Adelaide] = "http://www.bom.gov.au/sa/forecasts/adelaide.shtml"
  AUSCityMap[:Perth] = "http://www.bom.gov.au/wa/forecasts/perth.shtml"
  AUSCityMap[:Darwin] = "http://www.bom.gov.au/nt/forecasts/darwin.shtml"
  AUSCityMap[:Hobart] = "http://www.bom.gov.au/tas/forecasts/hobart.shtml"

  AUSCityVisibleMap = Common.new_orderd_hash
  AUSCityVisibleMap[:Brisbane] = true
  AUSCityVisibleMap[:Sydney] = true
  AUSCityVisibleMap[:Melbourne] = true
  AUSCityVisibleMap[:Canberra] = true
  AUSCityVisibleMap[:Hobart] = true
  AUSCityVisibleMap[:Adelaide] = true
  AUSCityVisibleMap[:Perth] = false
  AUSCityVisibleMap[:Darwin] = true

  # 서울·경기도 강원도 충청북도 충청남도 전라북도 전라남도 경상북도 경상남도 제주특별자치도
  KORCityOrderList = [:seo,:gwn,:cbk,:cnm,:jbk,:jnm,:gbk,:gnm,:jju]
  #KORCityOrderList = [:seo]

  KORCityXMLMap = Common.new_orderd_hash

  KORCityXMLMap[:seo] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109"
  KORCityXMLMap[:gwn] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=105"
  KORCityXMLMap[:cbk] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=131"
  KORCityXMLMap[:cnm] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=133"
  KORCityXMLMap[:jbk] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=146"
  KORCityXMLMap[:jnm] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=156"
  KORCityXMLMap[:gbk] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=143"
  KORCityXMLMap[:gnm] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=159"
  KORCityXMLMap[:jju] = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=184"

  #http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=125
  

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

  KORLocationCode = Common.new_orderd_hash
  KORLocationCode[:seo] = "11B10101"
  KORLocationCode[:gwn] = "11D10301"
  KORLocationCode[:cbk] = "11C10301"
  KORLocationCode[:cnm] = "11C20401"
  KORLocationCode[:jbk] = "11F10201"
  KORLocationCode[:jnm] = "11F20501"
  KORLocationCode[:gbk] = "11H10701"
  KORLocationCode[:gnm] = "11H20201"
  KORLocationCode[:jju] = "11G00201"
  
  
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

  def self.ftp_weather_data
    require 'net/ftp'
    File.unlink(WAETHER_AUS_FORECAST_TMP) if File.exist?(WAETHER_AUS_FORECAST_TMP)
    tries = 0
    begin
      tries += 1
      Net::FTP.open(WEATHER_AUS) do |ftp|
        ftp.passive = true
        ftp.login
        ftp.getbinaryfile(WAETHER_AUS_FORECAST, WAETHER_AUS_FORECAST_TMP)
        ftp.close
      end
    rescue Exception => e
      Rails.logger.error(e.message)
      if (tries < WEATHER_RETRY)
        sleep(2**tries)
      retry
      end
    end
  end

  def self.get_AU_data_html
    require 'nokogiri'
    require 'open-uri'

    infobox = Array.new

    doc = Nokogiri::HTML(open(WAETHER_AUS_FORECAST_TMP))

    doc.search('td').each do |link|
      infobox.push(link.content)
    end

  end

  def self.get_AU_data
    f = File.open(WAETHER_AUS_FORECAST_TMP, "r")
    lines = f.readlines
    lines.slice!(0)
    Rails.logger.info("AU_data: #{lines}")
    # Sydney#NSW#20120916#155532#IDN10064#20120917000000#19#Showers developing. Chance afternoon storm.#
    # Melbourne#VIC#20120916#155635#IDV10450#20120917000000#18#Shower or two clearing.#
    # Brisbane#QLD#20120916#155506#IDQ10095#20120917000000#24#A shower or two, possible storm.#
    # Perth#WA#20120916#111300#IDW12300#20120917000000#25#Few evening showers/storm risk.#
    # Adelaide#SA#20120916#050131#IDS10034#20120917000000#16#Partly cloudy.#
    # Hobart#TAS#20120916#144305#IDT65061#20120917000000#13#Chance of early drizzle.#
    # Canberra#NSW#20120916#155532#IDN10035#20120917000000#15#Showers developing.#
    # Darwin#NT#20120916#045840#IDD10150#20120917000000#34#Sunny.#
    lines
  end

  def self.saveWeather
    save_au_weather
    save_kr_weather
  end
  
  def self.save_au_weather
    ftp_weather_data
    info = get_AU_data
    return if !info.present?
    issuedOn = Time.parse(info[0].split("#")[2])
    Rails.logger.info("issuedOn: #{issuedOn}")
    weather = Weather.find_by_issuedOn(issuedOn)
    return if weather.present?
    ActiveRecord::Base.transaction do
    info.each do |i|
      e = i.split("#")
      w = Weather.new(:country => Okvalue::AU)
      w.location = e[0]
      w.issuedOn = Time.parse(e[2])
      w.dateOn = Common.date_format(Time.parse(e[5]))
      w.max = e[6].to_i
      w.forecast = e[7]
      w.save
    end
    end
  end

  def self.save_kr_weather
    info = get_KR_data
    return if !info.present?
    ActiveRecord::Base.transaction do
     info.each do |location,data|
      issuedOn = Time.parse(data[0])
      forecast = data[2]
      f = forecast.first
      dateon = Common.date_format(Time.parse(f[0]))
      w = Weather.where('dateOn = ? and location = ?', dateon, location).first
      w ||= Weather.new(:country => Okvalue::KR, :location => location, :dateOn => dateon)
      w.issuedOn = issuedOn
      w.forecast = f[1]
      w.min = f[2]
      w.max = f[3]
      w.save
    end
  end
  end

  def self.au_letter_to_icon(letter)
    return "rain" if letter =~ /([Ss])howers/
    return "chance_of_rain" if letter =~ /([Ss])hower/
    return "chance_of_rain" if letter =~ /([Dd])rizzle/
    return "mostly_cloudy" if letter =~ /([Cc])loudy/
    return "sunny" if letter =~ /([Ss])unny/
    nil
  end
  
  def self.kr_letter_to_icon(letter)
    return "cloudy" if letter =~ /구름많음/
    return "mostly_cloudy" if letter =~ /구름조금/
    return "chance_of_rain" if letter =~ /구름많고 비/
    
  end

  # icon list
  # chance_of_rain.png
  # chance_of_sleet.png
  # chance_of_snow.png
  # cloudy.png
  # flurries.png
  # haze.png
  # mist.png
  # mostly_cloudy.png
  # mostly_sunny.png
  # partly_cloudy.png
  # rain.png
  # sand.png
  # sleet.png
  # snow.png
  # storm.png
  # sunny.png
  # thunderstorm.png

  def self.get_KR_data
    infobox = Common.new_orderd_hash
    require 'open-uri'
    tm = nil
    KORCityOrderList.each do |location|
      each_info_box = Array.new
      doc = Nokogiri::XML(open(KORCityXMLMap[location]))
      doc.search('header/tm').each do |link|
        if !tm.nil? && !tm.eql?(link.content)
          Rails.logger.error("get_KR_data filed. tm does not match expected #{tm} but #{link.content} for #{location}")
          return nil
        end
        tm = link.content
        each_info_box.push(link.content)
      end
      doc.search('header/wf').each do |link|
        each_info_box.push(link.content)
      end
      location_data = Array.new
      doc.search('body/location').each do |node|
        if node[:city].eql? KORLocationCode[location]
          node.xpath('data').each do |data|
              data_for = Array.new
              data_for.push data.xpath('tmEf').first.text
              data_for.push data.xpath('wf').first.text
              data_for.push data.xpath('tmn').first.text
              data_for.push data.xpath('tmx').first.text
              location_data.push data_for
          end
        end
      end
      each_info_box.push location_data
      infobox[location] = each_info_box
    end
    infobox
  end
  
end
