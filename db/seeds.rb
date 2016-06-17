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

## Add some Event and Exercise sample data
# 		Creates new events using Faker helper gem
# 		which generates random data to populate database objects.
@evs = Array.new
@exers = Array.new
@comments = Array.new
@odd = true

@com_names = [Faker::StarWars, Faker::Superhero, Faker::Name]
@com_types = [Faker::Hipster, Faker::Hacker, Faker::StarWars]

#Create Events and child objects for them
n = Faker::Number.between(30, 50)
n.times do
  event = nil
  stime = Faker::Time.between(10.days.ago, DateTime.now + 40, :day)
  minFW = Faker::Number.between(30,180)
  etime = stime + 60*minFW
  # Create event
  if stime > Time.now
  	event = Event.create!(title: Faker::Team.sport.gsub(/\b\w/, &:upcase),
  												text: Faker::Shakespeare.as_you_like_it_quote,
  												starttime: stime,
  												endtime: etime)
  else
    event = Event.create!(title: Faker::Team.sport.gsub(/\b\w/, &:upcase),
                          text: Faker::Shakespeare.as_you_like_it_quote,
                          starttime: stime,
                          endtime: etime,
                          completed: true,
                          done_summary: Faker::Lorem.paragraph(2, true, 5),
                          done_additional: Faker::Company.catch_phrase,
                          done_created_at: (etime + 2.hour))
  end
	@evs.push(event) if debug

  # Create exercises for event
	n = Faker::Number.between(0, 5)
	n.times do
		t = Faker::Number.between(2, 25)
		description = "#{Faker::Hacker.verb} #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
		if debug
	  	@exers.push(event.exercises.create!(desc: description, duration: t))
	  else
	  	event.exercises.create!(desc: description, duration: t)
	  end
  end

  # Some Comments for Event
  n = Faker::Number.between(0, 10)
  n.times do
    for i in 0..1
      t = Faker::Number.between(0, 2)
      if t == 0
        commenter = Faker::Boolean.boolean ? @com_names[0].character : @com_names[0].droid if i.eql?(0)
        comment_text = @com_types[0].paragraph(1, true, 5) if i.eql?(1)
      elsif t == 1
        commenter = @com_names[1].name if i.eql?(0)
        comment_text = @com_types[1].say_something_smart if i.eql?(1)
      else
        commenter = @com_names[2].name if i.eql?(0)
        comment_text = @com_types[2].quote if i.eql?(1)
      end
    end
    #commenter = Faker::Name.name
    #comment_text =  = Faker::Hipster.paragraph(1, true, 5)
    if debug
      @comments.push(event.comments.create!(commenter: commenter, body: comment_text))
    else
      event.comments.create!(commenter: commenter, body: comment_text)
    end
  end

  # Video for every second Event
  if @odd
  	event.create_video!(link: 'https://www.youtube.com/watch?v=6QjIHnb5Ivs',
	  										title: 'Cortez the Killer',
	  										published_at: DateTime.now)
  end
  @odd ? @odd = false : @odd = true
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
puts "Created #{Comment.count} comments!"
puts "Created #{Video.count} videos!"
puts ""
