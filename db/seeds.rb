# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Change value according to whether want to print extra debug info
debug = false
puts "-- Debugging on: #{debug} --"

Event.destroy_all

# Event.create!([{
# 	title: "Jalkatreeni",
# 	text: "Jalkatreeni päivä",
# 	starttime: DateTime.new(2016,1,23,14,00),
# 	endtime: DateTime.new(2016,1,23,14,30)
# },
# {
# 	title: "Käsitreeni",
# 	text: "Ojentajat, hauikset ja työnnöt",
# 	starttime: DateTime.new(2016,1,21,16,15),
# 	endtime: DateTime.new(2016,1,21,17,30),
# 	completed: true
# },
# {
# 	title: "Intervalli treeni",
# 	text: "Interval juoksutreenit",
# 	starttime: DateTime.new(2016,1,25,17,00),
# 	endtime: DateTime.new(2016,1,25,18,30)
# },
# {
# 	title: "Aerobic",
# 	text: "Tunti aerobicia",
# 	starttime: DateTime.new(2016,1,22,19,30),
# 	endtime: DateTime.new(2016,1,22,20,30),
# },
# {
# 	title: "Juoksulenkki",
# 	text: "10 km maastolenkki",
# 	starttime: DateTime.new(2016,2,3,18,30),
# 	endtime: DateTime.new(2016,2,3,19,45),
# },
# {
# 	title: "Jalkatreeni 2",
# 	text: "Reidet ja takareidet - pyramid",
# 	starttime: DateTime.new(2016,2,5,17,15),
# 	endtime: DateTime.new(2016,2,5,18,45),
# },
# {
# 	title: "Intervalli treeni",
# 	text: "Interval juoksutreenit 2",
# 	starttime: DateTime.new(2016,2,25,18,30),
# 	endtime: DateTime.new(2016,2,25,19,45),
# },
# {
# 	title: "Juoksulenkki",
# 	text: "12 km lenkki",
# 	starttime: DateTime.new(2016,2,29,14,30),
# 	endtime: DateTime.new(2016,2,29,16,45),
# },
# {
# 	title: "Jalkatreenit",
# 	text: "Pohkeet ja kyykyt",
# 	starttime: DateTime.new(2016,2,29,17,15),
# 	endtime: DateTime.new(2016,2,29,18,45),
# }])

## Add some Event and Exercise sample data
# 		Creates new events using Faker helper gem
# 		which generates random data to populate database objects.
@evs = Array.new
@exers = Array.new
n = Faker::Number.between(10, 15)

n.times do
  stime = Faker::Time.between(10.days.ago, DateTime.now + 40, :day)
  minFW = Faker::Number.between(30,180)
  etime = stime + 60*minFW
	event = Event.create!(title: Faker::Team.sport.gsub(/\b\w/, &:upcase),
												text: Faker::Shakespeare.king_richard_iii_quote,
												starttime: stime,
												endtime: etime)
	@evs.push(event) if debug

	n = Faker::Number.between(2, 5)
	n.times do
		t = Faker::Number.between(2, 25)
		description = "#{Faker::Hacker.verb} #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
		if debug
	  	@exers.push(event.exercises.create!(desc: description, duration: t))
	  else
	  	event.exercises.create!(desc: description, duration: t)
	  end
  end
  event.create_video!(link: 'kakkaa', title: 'lumella', published_at: DateTime.now)
end

# debugging & info
if debug
	puts "Events:"
	puts @evs.inspect
	puts "----------------------------------------------------"
	puts "Exercises:"
	puts @exers.inspect
	puts "----------------------------------------------------"
end

puts "Created #{Event.count} events!"
puts "Created #{Exercise.count} exercises!"
puts ""
