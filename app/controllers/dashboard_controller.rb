class DashboardController < ApplicationController
	# @employees_late = Employee.all.map { |x| x.attendances.where(created_at: (1.month.ago..Time.current), attendance_type: 2).select("employee_id").distinct.count }
	# @checks_late = Employee.all.attendances.where(created_at: (1.month.ago..Time.current), attendance_type: 2).count
end
