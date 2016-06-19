class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
    	t.belongs_to :employee, index:true
    	t.integer :attendance_type
    	t.timestamps null: false
    end
  end
end
