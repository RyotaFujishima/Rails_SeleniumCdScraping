class AddColumnImports < ActiveRecord::Migration[5.0]
  def change
    add_column :imports, :done, :boolean, default: false, null: false
  end
end
