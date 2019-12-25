class ChangeDataScrapingToTitle < ActiveRecord::Migration[5.0]
  def change
    change_column :scrapings, :title, :string
  end
end
