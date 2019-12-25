class ImportsController < ApplicationController
  def import
    require "csv"
    
    # ファイルから1行づつ読み込む
    CSV.foreach("path/to/file.csv") do |row|
      logger.debug("==========#{row}============")
    end
  end

  def export
  end
  
  def index
    @imports = Import.where(done: false)
  end
end
