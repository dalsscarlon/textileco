class DashboardController < ApplicationController
	@checks_late = Employee.employees_with_type((1.month.ago..Time.current), 2, true)
	@delays = Employee.employees_with_type((1.month.ago..Time.current), 2, false)
end
