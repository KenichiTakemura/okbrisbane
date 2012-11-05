module Okiconv
  require 'iconv'

  def self.euckr_to_utf8(from_word)
    File.open("#{Rails.root}/tmp/euckr", 'w:euc-kr') do |file|
      file << from_word
    end

    `iconv -f EUC-KR -t UTF-8 #{Rails.root}/tmp/euckr > #{Rails.root}/tmp/utf8`
    if $? != 0
      puts from_word
    end
    to_word = File.read("#{Rails.root}/tmp/utf8")
    to_word
  end

end
