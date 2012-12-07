module Browser
  NOT_DETECTED = 1
  Safari = 2
  Chrome = 3
  Firefox = 4
  Opera = 5
  MSIE = 6

  MO_NOT_DETECTED = 10
  MO_Safari = 20
  MO_Chrome = 30
  MO_Firefox = 40
  MO_Opera = 50
  MO_MSIE = 60
  
  DEVISE_PHONE = 10
  DEVISE_PC = 1

  
  def self.ie?(request, agent)
    b = browser_detection(request, agent)
    b == MSIE || b == MO_MSIE
  end

  def self.browser_detection(request, agent=nil)
    return if !request.present? && !agent.present?
    agent = agent.presence || request.env['HTTP_USER_AGENT']
    browser_compatible = NOT_DETECTED
    devise = NOT_DETECTED
    if agent =~ /Safari/
      unless agent =~ /Chrome/
        version = agent.split('Version/')[1].split(' ').first.split('.').first
        browser_compatible = Safari
      else
        version = agent.split('Chrome/')[1].split(' ').first.split('.').first
        browser_compatible = Chrome
      end
    elsif agent =~ /Firefox/
      version = agent.split('Firefox/')[1].split('.').first
      browser_compatible = Firefox
    elsif agent =~ /Opera/
      version = agent.split('Version/')[1].split('.').first
      browser_compatible = Opera
    elsif agent =~ /MSIE/
      version = agent.split('MSIE')[1].split(' ').first
      browser_compatible = MSIE
    end
    if agent =~ /iPhone/
      devise = DEVISE_PHONE
    elsif agent =~ /Mobile/
      devise = DEVISE_PHONE
    else
      devise = DEVISE_PC
    end
    browser_compatible * devise
  end
end