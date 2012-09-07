 def current_weather
    require 'net/ftp'
    tries = 0
    begin
      tries += 1
      Net::FTP.open('ftp://ftp2.bom.gov.au/') do |ftp|
        ftp.getbinaryfile("anon/gen/fwo/IDA00100.dat")
        ftp.close
      end
    rescue Exception => e
      puts e
      if (tries < 2)
        sleep(2**tries)
        retry
      end
    end
  end
current_weather
