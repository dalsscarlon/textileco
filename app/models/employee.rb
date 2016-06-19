class Employee < ActiveRecord::Base
	include HasBarcode
	has_barcode :show_barcode,
              :outputter => :svg,
              :type => :code_128,
              :value => Proc.new { |p| p.barcode }
	enum status: [ :erased, :active, :inactive ]
	validates_presence_of :first_name, :last_name, :email
	scope :not_erased, -> { where( "status != 0") }

	after_save :set_barcode, :on => :create 
	
	def get_barcode(number)
		require 'barby'
		require 'barby/barcode/code_128'
		require 'barby/outputter/svg_outputter'

		barcode = Barby::Code128B.new("#{number}")

		barcode.to_svg(xdim:2, height:60)
	end
	private
	def set_barcode
	    barcode_text = Time.now.to_i.to_s + "#{id}"
	    update_column(:barcode, barcode_text)
	end
end
