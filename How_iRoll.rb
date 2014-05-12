 #!/usr/bin/env ruby

$LOAD_PATH << 'lib'
$LOAD_PATH << 'models'

require 'environment'
Environment.environment = ENV["ENVIRONMENT"] || "production"
$stderr = $stdout

require 'location'
require 'log'
require 'person'
#prints seperator lines and helps app be easier to read
def ascii
  trick = ['o', 'O', '0', '@', '*']
  print "\n"
  12.times do
    trick.each do|num|
      sleep(1.0/80.0)
      print "#{num}"
    end
  end
  print "\n\n"
end

def username?
  puts "Type 'opt' at any time for all available options.\nUsername?"
  name = gets
  if name == "opt\n"
    options('a')
    username?
  elsif
    @name = name
    return unless name
    name.chomp!
    person = Person.new(name)
    if person.save
      ascii
      puts "#{person.name} has been added with an id of #{person.id}"
      @id = person.id
      welcome
    elsif
      person = Person.find_by_name(name)
      @id = person.id
      returning_user
    end
  end
end

def returning_user
  ascii
  name = @name
  if name == 'ransolo'
    name = 'Father'
  end
  puts "Welcome back #{name}\nWould you like to start a new log or view past logs"
  @name = 'ransolo'
  input = gets.chomp!
  if input == 'new' || input == '1'
    ascii
    first_question
  elsif input == 'view'
    user = Person.find_by_name(@name)
    log = Log.all(user.id)

#     log.each do|log|{
#       # sleep(1.0/80.0)
#       print "#{log.type}"
# }
  elsif input == 'opt'
    options('10a')
    returning_user
  end
end

def first_question
  puts "How_iRoll"
  type = gets
  return unless type
  type.chomp!
  handle_answer(type)
end

def bike_path(type)
  ascii
  sub_type = gets.chomp!
  if sub_type == 'opt'
    options('1')
  elsif sub_type['1'] || sub_type['mtn'] || sub_type['mountain']
    puts 'Mountain biking is WAAAY cooler than street biking'
  elsif sub_type['2'] || sub_type['st'] || sub_type['street']
    puts 'Cool... I guess'
  end
  location_question(type, sub_type)
end

def car_path(type)
  ascii
  sub_type = gets.chomp!
  if sub_type == 'opt'
    options('2')
  elsif sub_type['1'] || sub_type ['n'] || sub_type ['no']
    puts "Whoa, look at Vim Diesel over here logging his Tokyo drift trips on a command line app... ever heard of a smart phone? eh?  Don't answer that question.. answer this one."
  elsif sub_type['2'] || sub_type['y'] || sub_type['yes']
    puts 'Classy'
  end
  location_question(type, sub_type)
end

def motorcycle_path(type)
  ascii
  sub_type = gets.chomp
  if sub_type == 'opt'
    options('3')
  elsif sub_type['1'] || sub_type['cr'] || sub_type['cruiser']
    puts "you're a badass like peter fonda from easy rider..."
  elsif sub_type['2'] || sub_type['y'] || sub_type['crotchrocket']
    puts "Someday you will resemble a possum on the side of the road."
  end
  location_question(type, sub_type)
end

def location_question(type, sub_type)
  ascii
  puts 'Where_iRoll'
  location_name = gets.chomp!
  location = Location.new(location_name)
  if location.save
    next_questions(type, sub_type, location)
  else
    location = Location.find_by_name(location_name)
    next_questions(type, sub_type, location)
  end
end


def next_questions(type, sub_type, location)
  ascii
  puts "How far is #{location.name} from your home"
  trip_time = gets.chomp!
  ascii
  puts "#{trip_time} is a long ride to take a ride... no?"

  puts "When_iRoll'd"
  date = gets.chomp!
  ascii
  puts "coolio, #{date} is as good a day as any"
  puts "Why_iRoll"
  reason = gets.chomp!
  puts "#{reason} is as good a reason as any"
  ascii
  person_id = @id
  Log.create_for(person_id, location.id, date, type, sub_type, trip_time, reason)
  log = Log.for(@id, location.id)
    print_success(log)
  # end
end


#Helper methods and options________------------_________--------
#prints welcome message and calls first_question method
def welcome
  ascii
  puts <<EOS
Welcome #{@name},

How_iRoll is a fun little app to help log your journies...
on wheels.  If you are walking or flying you can walk or
fly on to the next app buddy.

Ask yourself, #{@name}, this first question...

EOS
  first_question
end

def handle_answer(type)
  ascii
  if type['5'] || type['hid'] || type['hidden']
    options('0a')
  elsif type == 'opt'
    options('0')
  elsif type['1'] || type['bike'] || type['bicycle']
    type = 'bike'
    puts "You must be so proud biking...\nlike a hamster on a wheel...\nmtn or st biking?"
    bike_path(type)
  elsif type['2'] || type['Sun'] || type['Sunday driver']
    type = 'Sunday driver'
    puts 'You must be rolling in it to have all that gas money.  Is your ride vintage?'
      car_path(type)
  elsif type['3'] || type['moto'] || type['motorcycle']
    type = 'motorcycle'
    puts "You must be a bad ass or something, you think you're tough or something?\nDon't answer that tough guy/gal... answer this.\n Cruiser or crotchrocket?"
    motorcycle_path(type)
  elsif type['4'] || type['skate'] || type['skateboard']
    print "punk kid get off my lawn! and outta my app"
  elsif
    options('10')
    first_question

  end
end

def print_success(log)
  puts "On #{log[date]} you took a #{log[type]} ride for no other reason than #{log[reason]} in the city of #{location[name]} it took you #{log[trip_time]} minutes to get there and"
end

def intro
  puts <<EOS
Any time yall wanna see me again
Rewind this track right here, close your eyes
and picture me rollin
- 2Pac

EOS
wheels
puts <<EOS
This wheels on fire
rolling down the road
just notify my next of kin
this wheel shall explode!
- Bob Dylan

EOS
wheels
puts <<EOS
Its good sportsmanship to not pick up lost golf balls
while they are still rolling. - Mark Twain

EOS
wheels
username?
end

def wheels
  chars = %w[... ooo OOO 000 @@@ +++ *** |||  /// --- \\\\ ....  oooo OOOO 0000 @@@@ ++++ **** ||| \\\\ --- ///]
  4.times{ |j|
    print " "
    22.times{ |i|
      print chars[i % chars.length]
      sleep(1.0/15.0)
      print "\b\b\b"
    }
    # 1.times{print "\b"}
  }
  10.times{ |j|
    6.times{ |i|
      print chars[j % chars.length]
      sleep(1.0/35.0)
      print "\b\b\b"
      print".\bo\bO\b0\b@\b*\b-\b\\\b|\b/\b-\b"
      sleep(1.0/40.0)
    }
  }
  ascii

end


def options(num)
  ascii
  if num == '0'
    puts <<EOS
Options:
1 or 'bike'  or 'bicycle'
2 or 'Sun'   or 'Sunday driver'
3 or 'moto'  or 'motorcycle'
4 or 'skate' or 'skateboard'
5 or 'hid'   or 'hidden options'
EOS
first_question
  elsif num == '0a'
    puts <<EOS
Options:
1 or 'JO'
2 or 'TH'
3 or 'GD'
4 or 'BA'
EOS
    first_question
  elsif num == '1'
    puts <<EOS
Options:
1 or 'mtn' or 'mountain'
2 or 'st'  or 'street'
3 or 'hid' or 'hidden options'
EOS
    bike_path
  elsif num == '2'
    puts <<EOS
Options:
1 or 'y' or 'yes'
2 or 'n'  or 'no'
3 or 'hid' or 'hidden options'
EOS
elsif num == '3'
  puts <<EOS
Options: ? Cruiser or crotchrocket?
1 or 'cruiser'
2 or 'cr' or 'crotchrocket'
3 or 'hid' or 'hidden options'
EOS
elsif num == 'a'
  puts <<EOS
Options: ? Username?
Enter your unique username
EOS
  elsif num == '10'
    puts <<EOS
not a valid option... dummy
EOS
  elsif num == '10a'
    puts <<EOS
Options: ? Returning user?
1 or 'new'
2 or 'view'
EOS
  end
end

wheels

intro
