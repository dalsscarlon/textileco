class Employee < ActiveRecord::Base
	include HasBarcode
	has_barcode :show_barcode,
              :outputter => :svg,
              :type => :code_128,
              :value => Proc.new { |p| p.barcode }
	enum status: [ :erased, :active, :inactive ]
	validates_presence_of :first_name, :last_name, :email
	scope :not_erased, -> { where( "status != 0") }

	has_many :attendances

	after_save :set_barcode, :on => :create 
	
	def get_barcode(number)
		require 'barby'
		require 'barby/barcode/code_128'
		require 'barby/outputter/svg_outputter'

		barcode = Barby::Code128B.new("#{number}")

		barcode.to_svg(xdim:2, height:60)
	end

	def has_checked?(day, types)
		attendances.where(created_at: day.beginning_of_day..day.end_of_day, attendance_type: types).any?
	end

	def checks_in_day(day, types)
		attendances.where(created_at: day.beginning_of_day..day.end_of_day, attendance_type: types)
	end

	def count_checks(range_days, type)
		attendances.where(created_at: range_days, attendance_type: type).count
	end

	def self.employees_with_type(range_days, type, distinct_employees)
		employees = 0;
		delays = 0;
		Employee.all.each do |employee|
			count_lates = employee.count_checks(range_days, type)
			employees += 1 if count_lates > 0
			delays += count_lates if !count_lates.nil?
		end
		if distinct_employees
			return employees 
		else
			return delays
		end
	end

	private
	def set_barcode
	    barcode_text = Time.now.to_i.to_s + "#{id}"
	    update_column(:barcode, barcode_text)
	end
end
