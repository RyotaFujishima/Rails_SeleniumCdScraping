class ScrapingsController < ApplicationController
  def index
    @scrapings = Scraping.all
  end

  def show
  end
end
