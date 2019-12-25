class CreateScrapings < ActiveRecord::Migration[5.0]
  def change
    create_table :scrapings do |t|
      
      t.string :product_number
      t.string :model_number
      t.string :name
      t.integer :track_number
      t.integer :title
      t.string :source
      t.boolean :done,  default: false, null: false

      t.timestamps
    end
  end
end
