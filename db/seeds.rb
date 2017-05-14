# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Change value according to whether want to print extra debug info
debug = false
puts "-- Debugging on: #{debug} --"

Event.destroy_all

## Add some Event and Exercise sample data
#     Creates new events using Faker helper gem
# 		which generates random data to populate database.
#     
@evs = Array.new
@exers = Array.new
@comments = Array.new
@odd = true

@com_char = [
  Proc.new { Faker::Ancient.god },
  Proc.new { Faker::Ancient.hero },
  Proc.new { Faker::Friends.character },
  Proc.new { Faker::GameOfThrones.character },
  Proc.new { Faker::HarryPotter.character },
  Proc.new { Faker::LordOfTheRings.character },
  Proc.new { Faker::StarWars.character },
  Proc.new { Faker::StarWars.droid },
  Proc.new { Faker::Superhero.name },
  Proc.new { Faker::TwinPeaks.character}
]

@com_quote = [
  Proc.new { Faker::ChuckNorris.fact },
  Proc.new { Faker::Friends.quote },
  Proc.new { Faker::Hacker.say_something_smart },
  Proc.new { Faker::HarryPotter.quote },
  Proc.new { Faker::StarWars.quote },
  Proc.new { Faker::StarWars.wookie_sentence },
  Proc.new { Faker::TwinPeaks.quote }
]

@com_location = [
  Proc.new { Faker::Address.state },
  Proc.new { Faker::Friends.location },
  Proc.new { Faker::HarryPotter.location },
  Proc.new { Faker::LordOfTheRings.location },
  Proc.new { Faker::Pokemon.location },
  Proc.new { Faker::StarWars.planet },
  Proc.new { Faker::TwinPeaks.location }
]

@com_name = [
  Proc.new { Faker::Name.name },
  Proc.new { Faker::Pokemon.name },
  Proc.new { Faker::RockBand.name },
  Proc.new { Faker::Superhero.name }
]

@catch_phrase = [
  Proc.new { Faker::Company.catch_phrase }
]

@vid_opts = [
  ['Cortez the Killer', 'https://www.youtube.com/watch?v=6QjIHnb5Ivs'],
  ['Pekka Pouta', 'https://www.youtube.com/watch?v=o6T9ESB_UcA']
]

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
  												endtime: etime
    )
  else
    event = Event.create!(title: Faker::Team.sport.gsub(/\b\w/, &:upcase),
                          text: Faker::Shakespeare.as_you_like_it_quote,
                          starttime: stime,
                          endtime: etime,
                          completed: true,
                          done_summary: Faker::Lorem.paragraph(2, true, 5),
                          done_additional: Faker::Company.catch_phrase,
                          done_created_at: (etime + 2.hour)
    )
  end
  event.created_at = stime - 10.days
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
    commenter = @com_char[Faker::Number.between(0, @com_char.length - 1)].call
    comment_text = @com_quote[Faker::Number.between(0, @com_quote.length - 1)].call
    e_time = event.created_at
    comment_time = Faker::Time.between(e_time, DateTime.now, :all)

    if debug
      @comments.push(
        event.comments.create!(
          commenter: commenter,
          body: comment_text,
          created_at: comment_time
        )
      )
    else
      event.comments.create!(commenter: commenter, body: comment_text)
    end
  end

  # Video for every second Event
  if Faker::Boolean.boolean
    i = Faker::Number.between(0, @vid_opts.length - 1)
  	event.create_video!(
      title: @vid_opts[i][0],
      link: @vid_opts[i][1],
	  	published_at: DateTime.now
    )
  end
  @odd ? @odd = false : @odd = true
end

## Debug info
if debug
	puts "Events:"
  for e in @evs
    puts e.inspect
    puts ""
  end
	puts "----------------------------------------------------"
	puts "Exercises:"
  for ex in @exers
    puts ex.inspect
    puts ""
  end
	puts "----------------------------------------------------"
  puts "Comments:"
  for c in @comments
    puts c.inspect
    puts ""
  end
end

puts "Created #{Event.count} events!"
puts "Created #{Exercise.count} exercises!"
puts "Created #{Comment.count} comments!"
puts "Created #{Video.count} videos!"
puts ""

