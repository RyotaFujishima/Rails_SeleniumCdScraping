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
        driver.manage.timeouts.implicit_wait = 100
        
        
        driver.find_element(:name, 'txtLoginId').send_keys(id)
        driver.find_element(:name, 'txtLoginPass').send_keys(password)
        driver.find_element(:css, '#login_do').click

        sleep(5)
        logger.debug("================================= driver = #{driver.find_element(:css, "#wrapper > div.bmm-l-wrap.my-page > div.my-page__sidebar > div > div.my-page-profile > div.my-page-profile__btns > div:nth-child(1) > a > span").text}")
        # 左上の出品するボタンクリック
        driver.find_element(:css, "#wrapper > div.bmm-l-wrap.my-page > div.my-page__sidebar > div > div.my-page-profile > div.my-page-profile__btns > div:nth-child(1) > a > i").click
        sleep(10)
        logger.debug("=================================")
        # 出品取得
        @info = driver.find_element(:css, ".bmm-c-heading__ttl").text
        logger.debug("================================= shuppin = #{@info}")

        
        
        # driver.find_element(:css, "#wrapper > div.bmm-l-wrap.my-page > div.my-page__sidebar > div > div.my-page-menu > ul > li:nth-child(5) > a").click

        # 商品画像文書取得
        # @info = driver.find_element(:css, "#SellUI-react-component-26d08da7-ec35-423c-b0c6-f14272c477b8 > div > div > div > div.bmm-l-cnt__body.sell-body.is-btnbar-fixed > div > p.sell-info-bar__ttl").text
        # logger.debug("================================= info = #{@info}")
        driver.quit

      
  end
      
end
