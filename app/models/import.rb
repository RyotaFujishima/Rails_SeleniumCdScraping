class Import < ApplicationRecord
    
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      if Import.find_by(model_number: row[1])
        logger.debug("#{row["model_number"]}は既に存在します")
      else
        i = Import.new(
          product_number: row[0],
          model_number: row[1],
          done: false
          )
          if i.save!
            logger.debug("#{row["model_number"]}を保存")
          else
            logger.debug("保存に失敗しました")
          end
      end
    end
  end
  
end
