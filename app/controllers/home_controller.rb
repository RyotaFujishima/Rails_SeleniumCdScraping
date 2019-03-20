class HomeController < ApplicationController
    
  def top
  end
  
  def selen
      
        require 'selenium-webdriver'
        require 'net/http'
        require 'uri'
        
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        
        id = ''
        password = ''
        @url = 'https://www.buyma.com/login/'
        
        
        
        driver.navigate.to @url
        driver.manage.timeouts.implicit_wait = 30
        
        
        driver.find_element(:name, 'txtLoginId').send_keys(id)
        driver.find_element(:name, 'txtLoginPass').send_keys(password)
        driver.find_element(:css, '#login_do').click

        sleep(5)
        logger.debug("================================= driver = #{driver.find_element(:css, "#js-pc-header-my-link > span").text}")

        # 出品するクリック
        @shuppin = driver.find_element(:css, "#wrapper > div.bmm-l-wrap.my-page > div.my-page__sidebar > div > div.my-page-profile > div.my-page-profile__btns > div:nth-child(1) > a > i").text
        logger.debug("================================= shuppin = #{@shuppin}")
        # driver.switch_to.frame("setting_window")
        sleep(10)
        driver.find_element(:css, "#wrapper > div.bmm-l-wrap.my-page > div.my-page__sidebar > div > div.my-page-menu > ul > li:nth-child(5) > a").click
        # 商品画像文書取得
        @info = driver.find_element(:css, "#SellUI-react-component-04781482-f2e4-4d6b-8c8c-d64cf95a21a1 > div > div > div > div.bmm-l-cnt__body.sell-body.is-btnbar-fixed > form > div:nth-child(1) > div > div > div.col-3 > div > div > p:nth-child(1)").text

        driver.quit

      
  end
      
end
