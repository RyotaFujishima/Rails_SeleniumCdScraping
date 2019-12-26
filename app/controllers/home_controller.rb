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
      save_array = []
      
      imports = Import.where(done: false)
      imports.each do |import|
        array.clear
        save_array.clear
        
        # neowing-----------------------------------------------------------------------------
        # Neowing Top URL
        driver.get 'http://www.neowing.co.jp/' #URLを開く
        
        # セレクトタグで「全てのCD」を選択
        select = Selenium::WebDriver::Support::Select.new(driver.find_element(:name, 'term.media_format'))
        # select.select_by(:value, 'cd')    # valueの値で選択
        select.select_by(:text, 'すべてのCD') # 表示テキストで選択
        # select.select_by(:index, 3)           # インデックス（0始まり）で選択
        logger.debug("=======セレクトタグを選択==========")
        
        # 検索コードを入力し、検索結果ページに移動
        element = driver.find_element(:name, 'q')
        element.send_keys(import.product_number)   #CD型番
        logger.debug("=======#{import.model_number} 検索==========")
        
        # 検索ボタンを取得しサブミット
        element = driver.find_element(:class, 'search-button')  #検索ボタン
        element.submit

        # 検索結果の第一要素をクリック
        element = driver.find_element(:class, 'item-wrap').click
        logger.debug("=======移動:「　#{driver.current_url}　」 ==========")

        # トラック名を取得
        cd_name = driver.find_element(:xpath, '//*[@id="content"]/div[2]/div[2]/div/h1/span').text
        
        # トラックNoと曲名を取得
        driver.find_elements(:xpath, '//*[@class="tracklist"]/tbody/tr').each do |node|
            array << [
              import.model_number,
              cd_name,
              node.find_element(:css, 'td.track-no').text,
              node.find_element(:css, 'td.track-title').text,
              "neo",
              ]
        end
        
        logger.debug("=======#{import.model_number} インポート完了==========")
        
        logger.debug("=====================保存=========================")
          
          array.each do |i|
            logger.debug("#{i[2]}) タイトル:#{i[3]} : #{i[1]}" )
            #配列毎にデータベースに保存
            if @scraping = Scraping.create!(
              model_number: i[0],
              name: i[1],
              track_number: i[2],
              title: i[3],
              source: i[4], 
              done: false
              )
              
              # 保存が完了したものをsave_arrayに格納する
              save_array << [Import.find_by(model_number: i[0]).model_number]
              logger.debug("==========#{save_array[0]}格納完了=============")
            else
              logger.debug("==========格納に失敗=============")
            end #if @scraping = Scraping.create!(
          end # array.each do |i|
          
          # save_arrayに格納されたものに完了フラグを立てる
          save_array.each do |s|
            done_import = Import.find_by(model_number: s)
            if done_import.update!(done: true)
              logger.debug("==========#{done_import.model_number}完了=============")
            else
              logger.debug("==========完了フラグが正常につきませんでした=============")
            end
          end
        logger.debug("=====================保存完了=======================")
        
      end

      driver.quit
  end #selen
  
  def selen2
      @imports = Import.where(done: false)
  end
  
end