#!/usr/bin/env ruby

require "net/http"
Net::HTTP.version_1_2

if __FILE__ == $0
  Net::HTTP.start('www.okbrisbane-devel.com', 80) do |http|
  response = http.get("/counters/batch")
  case response
    when Net::HTTPSuccess
      puts "Counter batch Success #{response.body}"
    else
      puts "#{response.body}"
    end
  end
end
