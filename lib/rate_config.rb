# -*- coding: utf-8 -*-
module RateConfig

  BUY = 1
  SELL = 2
  def self.saveRate
    rates = RateConfig.getData
    issuedOn = Time.parse(rates[12])
    rate = Rate.find_by_issuedOn(issuedOn)
    return if rate.present?
    ActiveRecord::Base.transaction do
      [Okvalue::AU,Okvalue::NZ,Okvalue::US].each_with_index do |c,i|
        rate = Rate.new
        rate.issuedOn =  issuedOn
        rate.currency_from = Okvalue::KR
        rate.currency_to = c
        rate.buy_or_sell = BUY
        rate.rate_a = rates[0+i]
        rate.rate_b = rates[3+i]
        rate.save
        rate = Rate.new
        rate.issuedOn =  issuedOn
        rate.currency_from = Okvalue::KR
        rate.currency_to = c
        rate.buy_or_sell = SELL
        rate.rate_a = rates[6+i]
        rate.rate_b = rates[9+i]
        rate.save
      end
    end
  end

  def self.getData
    require 'nokogiri'
    require 'open-uri'

    infobox = Array.new
    # ExchangeRate-AUD-BUY
    # ExchangeRate-NZD-BUY
    # ExchangeRate-USD-BUY
    # SendRate-AUD-SEND
    # SendRate-NZD-SEND
    # SendRate-USD-SEND
    # ExchangeRate-AUD-SELL
    # ExchangeRate-NZD-SELL
    # ExchangeRate-USD-SELL
    # SendRate-AUD-RECV
    # SendRate-NZD-RECV
    # SendRate-USD-RECV
    # ExchangeRate-DATE
    # SendRate-USD-DATE

    doc = Nokogiri::HTML(open(Okvalue::RATE))

    doc.search('td.buy').each do |link|
      infobox.push(link.content)
    end
    doc.search('td.sell').each do |link|
      infobox.push(link.content)
    end

    doc.search('div.date p').each do |link|
      infobox.push(link.content)
    end

    Rails.logger.debug("rate info: #{infobox}")
    infobox
  end
  
  def self.cleanup
    rate_info = Rate.older(3)
    if rate_info.present?
      rate_info.each do |rate|
        rate.destroy
      end
    end
  end

end
