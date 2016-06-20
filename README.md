# textileco
Record of employees attendance

# Setup

* Clone repository
* Run 'bundle install'
* Create the database with 'rake db:create db:migrate'
* Run 'rake db:seed' to create 50 employees with their own attendence

# Problem background

In your first day as developer you are consulting for a customer who owns a textile company named Textile.Co. The company has 1000 employees.
When a new employee joins Textile.Co, the employee receives a new BADGE card imprinted with a unique barcode, each employee has a different BADGE card.
Textile.Co bought a punch card machine that can send a HTTP’s JSON POST payloads to a server and wants to use it to track arrivals and departures of employees. Working hours for employees are from 9 am to 6 pm, Monday to Friday.
The customer wants you to implement the following features:

# Features
1. Your customer wants to be able to see which employees are arriving late.
2. Your customer wants to know which employees are not coming to work at all.
3. Your customer’s employees are complaining that the reported hours for a given period
are wrong, so your customer wants to give each of his employees the opportunity to review their current period working hours report 3 days before the paycheck day.


