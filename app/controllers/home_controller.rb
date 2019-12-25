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
      model_numbers = ['KSCL-3112']
      model_numbers.each do |model_number|

      # neowing-----------------------------------------------------------------------------
      # imports = Import.all
      # imports.each do |import|

        # Neowing Top URL
        driver.get 'http://www.neowing.co.jp/' #URLを開く
        
        # 検索コードを入力し、検索結果ページに移動
        element = driver.find_element(:name, 'q')
        # element.send_keys(import.product_number)   #CD型番
        element.send_keys(model_number)   #CD型番
        # logger.debug("=======#{import.model_number} 検索==========")
        logger.debug("=======#{model_number} 検索==========")
        
        # 検索ボタンを取得しサブミット
        element = driver.find_element(:class, 'search-button')  #検索ボタン
        element.submit
        # logger.debug("=======検索結果「#{driver.current_url}」へ移動しました==========")
        
        # 検索結果の第一要素をクリック
        element = driver.find_element(:class, 'item-wrap').click
        # logger.debug("=======第一要素「#{driver.current_url}」へ移動しました==========")
        
        # トラック名を取得
        cd_name = driver.find_element(:xpath, '//*[@id="content"]/div[2]/div[2]/div/h1/span').text
        
        # トラックNoと曲名を取得
        driver.find_elements(:xpath, '//*[@class="tracklist"]/tbody/tr').each do |node|
            array << [
              # import.model_number,
              model_number,
              cd_name,
              node.find_element(:css, 'td.track-no').text,
              node.find_element(:css, 'td.track-title').text,
              "neo",
              ]
        end
        # logger.debug("=======#{import.model_number} インポート完了==========")
        logger.debug("=======#{model_number} インポート完了==========")

      end

      # end
      
      driver.quit
      # neowing--------------------------------------------------------------------------------
      
    logger.debug("=====================保存=========================")
      array.each do |i|
        logger.debug("#{i[2]}) タイトル:#{i[3]} : #{i[1]}" )
        # 保存アクションの追加
        @scraping = Scraping.create!(
          model_number: i[0],
          name: i[1],
          track_number: i[2],
          title: i[3],
          source: i[4], 
          done: false
          )
      end
    logger.debug("=====================保存完了=========================")
  end
  
  def selen2
    
      imports = Import.all
      imports.each do |import|
        logger.debug("#{import.product_number}")
      end
      redirect_to root_path
  end
  
end