class ImportsController < ApplicationController
  def import
    Import.import(params[:file])
    logger.debug("===========CSVを取得しました============")
    redirect_to "/imports"
  end

  def export
  end
  
  def index
    @imports = Import.all
    @n = 1
  end
  
  def done
    @imports = Import.where(done: true)
  end
  
  def non_done
    @imports = Import.where(done: false)
  end
end
