class ScrapingsController < ApplicationController
  def index
    @scrapings = Scraping.all
  end

  def show
    @scrapings = Scraping.where(model_number: params[:model_number])
  end
end
