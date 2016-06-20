class Attendance < ActiveRecord::Base
	enum attendance_type: [ :checkin_ok, :checkout_ok, :checkin_late, :checkout_early, :extra ]

	belongs_to :employee

	before_save :set_attendance_type

	def set_attendance_type
		checktime = self.created_at.strftime('%I:%M %P')
		if self.created_at.workday?
			if employee.has_checked?(self.created_at, [0, 2])
				self.attendance_type = (checktime.to_time >= BusinessTime::Config.end_of_workday.to_time ? :checkout_ok : :checkout_early)
			else
				self.attendance_type = (checktime.to_time <= BusinessTime::Config.beginning_of_workday.to_time ? :checkin_ok : :checkin_late)
			end
		else
			self.attendance_type = :extra
		end

	end
end
