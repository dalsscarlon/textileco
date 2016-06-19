class AddIndexToEmployees < ActiveRecord::Migration
  def change
  	add_index :employees, :barcode, unique: true
  end
end
