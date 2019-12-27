require 'csv'

class ScrapingsController < ApplicationController
  def index
    @scrapings = Scraping.all.to_a.uniq { |item| item.model_number }
  end

  def show
    @scrapings = Scraping.where(model_number: params[:model_number])
    @model_number = params[:model_number]
  end
  
  def csv_export
    if params[:model_number]
      @scrapings = Scraping.where(model_number: params[:model_number])
    else
      @scrapings = Scraping.all
    end
    send_scrapings_csv(@scrapings)
  end
  
  def send_scrapings_csv(scrapings)
    csv_data = CSV.generate do |csv|
      header = %w(track_number title name product_number model_number source)
      csv << header
      
      scrapings.each do |scraping|
        values = [
          scraping.track_number,
          scraping.title,
          scraping.name,
          scraping.product_number,
          scraping.model_number,
          scraping.source,
          ]
        csv << values
      end
    end
    send_data(csv_data, filename: "CD-Data.csv")
  end
end
