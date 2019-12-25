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
      
      array = []
      model_numbers = ['KSCL-3112', 'UICZ-8205', 'VTCL-60466', 'QWCE-00654', 'VICL-65250', 'UICZ-8205']

      # neowing-----------------------------------------------------------------------------
      model_numbers.each do |model_number|
        
        # Neowing Top URL
        driver.get 'http://www.neowing.co.jp/' #URLを開く
        
        # 検索コードを入力し、検索結果ページに移動
        element = driver.find_element(:name, 'q')
        element.send_keys(model_number)   #CD型番
        # logger.debug("=======検索フォームにキーワードを入力しました==========")
        
        # 検索ボタンを取得しサブミット
        element = driver.find_element(:class, 'search-button')  #検索ボタン
        element.submit
        # logger.debug("=======検索結果「#{driver.current_url}」へ移動しました==========")
        
        # 検索結果の第一要素をクリック
        element = driver.find_element(:class, 'item-wrap').click
        # logger.debug("=======第一要素「#{driver.current_url}」へ移動しました==========")
        
        # トラック名を取得
        track_name = driver.find_element(:xpath, '//*[@id="content"]/div[2]/div[2]/div/h1/span').text
        
        # トラックNoと曲名を取得
        driver.find_elements(:xpath, '//*[@class="tracklist"]/tbody/tr').each do |node|
            array << [
              node.find_element(:css, 'td.track-no').text,
              node.find_element(:css, 'td.track-title').text,
              track_name,
              model_number,
              'neo'
              ]
        end
        

      end
      
      driver.quit
      # neowing--------------------------------------------------------------------------------
      
    logger.debug("==============================================")
      array.each do |i|
        logger.debug("#{i[0]}) #{i[1]} no:#{i[3]} soce:#{i[4]} ")
      end
    logger.debug("==============================================")
  end
  
  def selen2
      

  end
  
end