# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## 50 employees
50.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email
    
    employee = Employee.create({ first_name: first_name, last_name: last_name, email: email	})

    
   	## attendances
   	rounds = (35..60).to_a.sample
   	# taking one random day off
   	day_off = rand(rounds)
   	(rounds).times do |v|
   		workday = (v).business_days.ago
   		if day_off != v
	   		## checkin  between 20 min before be late to 20 min late
	   		extra_time = (-20*60..20*60).to_a.sample
	   		checkin_time = Time.parse(BusinessTime::Config.beginning_of_workday).seconds_since_midnight + extra_time
	   		checkin_time = Time.at(checkin_time).utc
	   		employee.attendances.create({
	          created_at: workday.change(hour: checkin_time.hour, min: checkin_time.min, sec: checkin_time.sec)
	        })

	        ## checkout  between 20 min before time to 20 min late
	   		extra_time = (-5*60..20*60).to_a.sample
	   		checkout_time = Time.parse(BusinessTime::Config.end_of_workday).seconds_since_midnight + extra_time
	   		checkout_time = Time.at(checkout_time).utc
	   		employee.attendances.create({
	          created_at: workday.change(hour: checkout_time.hour, min: checkout_time.min, sec: checkout_time.sec)
	        })
	    end

   	end
end