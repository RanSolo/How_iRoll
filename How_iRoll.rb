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
      # sleep(1.0/80.0)
      print "#{num}"
    end
  end
  print "\n\n"
end
ascii

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
      puts "#{person.name} has been added"
      welcome
    elsif
      username = person.name
      returning_user(username)
    end
  end
end

def returning_user(username)
  ascii
  puts "Welcome back #{username}\nWould you like to start a new log or view past logs"
  input = gets.chomp!
  if input == "new"
    ascii
    first_question
  elsif input == 'view'
    log.all
  elsif input == 'opt'
    options('10a')
    returning_user(username)
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
  puts "You must be so proud biking...\nlike a hamster on a wheel...\nmtn or st biking?"
  input = gets.chomp!
  if input == 'opt'
    options('1')
  elsif input['1'] || input['mtn'] || input['mountain']
    ascii
    puts 'Mountain biking is WAAAY cooler than street biking'
    sub_type = input
    next_questions(type, sub_type)
  elsif input['2'] || input['st'] || input['street']
    ascii
    puts 'Cool... I guess'
    next_questions(type, sub_type)
  end
end

def car_path(type)
  ascii
  puts 'You must be rolling in it to have all that gas money.  Is your ride vintage?'
  input = gets.chomp!
  if input == 'opt'
    options('2')
  elsif input['1'] || input ['n'] || input ['no']
    ascii
    puts "Whoa, look at Vim Diesel over here logging his Tokyo drift trips on a command line app... ever heard of a smart phone? eh?  Don't answer that question.. answer this one."
    sub_type = input
    next_questions(type, sub_type)
  elsif input['2'] || input['y'] || input['yes']
    ascii
    puts 'Classy'
    sub_type = input
    next_questions(type, sub_type)
  end
end

def motorcycle_path(type)
  ascii
  puts "You must be a bad ass or something, you think you're tough or something?\nDon't aswer that tough guy/gal... answer this\n Cruiser or crotchrocket"
  sub_type = gets.chomp
  if sub_type == 'opt'
    options('3')
  elsif sub_type['1'] || sub_type['y'] || sub_type['yes']
    ascii
    puts 'You must be then'
    log_items.push(sub_type)
    next_questions(type, sub_type)
  end
end

def next_questions(type, sub_type)
  ascii
  puts 'Where_iRoll'
  location = gets.chomp!
  ascii
  puts "How far is #{location} from your home"
  travel_time = gets.chomp!
  ascii
  puts "#{travel_time} is a long ride to take a ride... no?"
  puts "When_iRoll'd"
  date = gets.chomp!
  ascii
  puts "coolio, #{date} is as good a day as any"
  puts "Why_iRoll"
  reason = gets.chomp!
  puts "#{reason} is as good a reason as any"
  ascii
  puts "On #{date} you took a #{type} ride for no other reason than #{reason} in the city of #{location} it took you #{travel_time} minutes to get there and"
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
  if type['5'] || type['hid'] || type['hidden']
    options('0a')
  elsif type == 'opt'
    options('0')
  elsif type['1'] || type['bike'] || type['bicycle']
    type = 'bike'
    bike_path(type)
  elsif type['2'] || type['Sun'] || type['Sunday driver']
    type = 'Sunday driver'
      car_path(type)
  elsif type['3'] || type['moto'] || type['motorcycle']
    type = 'motorcycle'
    motorcycle_path(type)
  elsif type['4'] || type['skate'] || type['skateboard']
    print "punk kid get off my lawn! and outta my app"
  elsif
    options('10')
    first_question
  end
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
username?
