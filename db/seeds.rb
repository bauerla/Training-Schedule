# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.destroy_all

Event.create!([{
	title: "Jalkatreeni", 
	text: "Jalkatreeni päivä", 
	starttime: DateTime.new(2016,1,23,14,00), 
	endtime: DateTime.new(2016,1,23,14,30)
},
{
	title: "Käsitreeni", 
	text: "Ojentajat, hauikset ja työnnöt", 
	starttime: DateTime.new(2016,1,21,16,15), 
	endtime: DateTime.new(2016,1,21,17,30),
	completed: true
},
{
	title: "Intervalli treeni", 
	text: "Interval juoksutreenit", 
	starttime: DateTime.new(2016,1,25,17,00),
	endtime: DateTime.new(2016,1,25,18,30)
},
{
	title: "Aerobic", 
	text: "Tunti aerobicia", 
	starttime: DateTime.new(2016,1,22,19,30), 
	endtime: DateTime.new(2016,1,22,20,30),
},
{
	title: "Juoksulenkki", 
	text: "10 km maastolenkki", 
	starttime: DateTime.new(2016,2,3,18,30), 
	endtime: DateTime.new(2016,2,3,19,45),
},
{
	title: "Jalkatreeni 2", 
	text: "Reidet ja takareidet - pyramid", 
	starttime: DateTime.new(2016,2,5,17,15), 
	endtime: DateTime.new(2016,2,5,18,45),
}])

p "Created #{Event.count} events"