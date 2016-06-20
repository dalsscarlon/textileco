class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_filter :verify_authenticity_token, :only => :clock

  def clock
  	@employee = Employee.find_by(barcode: params[:barcode])
  	if @employee
      push_card = @employee.attendances.create(created_at: Time.current.in_time_zone)

      if push_card.save
        render json: {message: :ok, status: :ok}.to_json
      else
        render json: { errors: push_card.errors.full_messages.first, status: :unprocessable_entity }.to_json
      end
    else
    	render json: { message: "Barcode not found", status: :unprocessable_entity }.to_json
    end

    
	

  end
end
