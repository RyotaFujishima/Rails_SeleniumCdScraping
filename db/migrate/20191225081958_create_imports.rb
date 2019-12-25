class CreateImports < ActiveRecord::Migration[5.0]
  def change
    create_table :imports do |t|
      t.string :product_number
      t.string :model_number

      t.timestamps
    end
  end
end
