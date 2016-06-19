class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
		t.string :first_name, null: false
    	t.string :last_name, null: false
    	t.string :email, null: false
    	t.string :barcode
    	t.integer :status, null: false, default: 1
    	t.timestamps null: false
    end
  end
end
