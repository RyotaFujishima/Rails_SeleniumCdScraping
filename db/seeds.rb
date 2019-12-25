require "csv"
 
CSV.foreach('db/scraping.csv', headers: true) do |row|
  Import.create(
      product_number: row['product_number'],
      model_number: row['model_number'],
      )
end