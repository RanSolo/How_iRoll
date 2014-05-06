 #!/usr/bin/env ruby

$LOAD_PATH << 'lib'
$LOAD_PATH << 'models'

require 'environment'
Environment.environment = 'test'
$stderr = $stdout

require 'log'

def username?
  puts "Type 'opt' at any time for all available options.\nUsername?"
  input = gets.chomp!
  @name = input
  if @name == 'opt'
    options('a')
    username?
  end
  welcome
end

def welcome
  # ascii
  puts <<EOS
Welcome #{@name},

How_iRoll is a fun little app to help log your journies...
on wheels.  If you are walking or flying you can walk or
fly on to the next app buddy.

Ask yourself, #{@name}, this first question...

EOS
  first_question
end

def bike_path
  # ascii
  puts "You must be so proud biking...\nlike a hamster on a wheel...\nmtn or st biking?"
  input = gets.chomp!
  if input == 'opt'
    options('1')
  elsif input['1'] || input['mtn'] || input['mountain']
    puts 'Mountain biking is WAAAY cooler than street biking'
    sub_type = input
    Log.new(sub_type).save
    second_question
  elsif input['2'] || input['st'] || input['street']
    # ascii
    puts 'Cool... I guess'
    second_question
  end
end

def car_path
  # ascii
  puts 'You must be rolling in it to have all that gas money.  Is your ride vintage?'
  input = gets.chomp
  if input == 'opt'
    options('2')
  elsif input['2'] || input['y'] || input['yes']
    # ascii
    puts 'Classy'
    badass_boolean = input
    Log.new(badass_boolean).save
    second_question
  end
end

def motorcycle_path
  # ascii
  puts "You must be a bad ass or something, you think you're tough or something?"
  input = gets.chomp
  if input == 'opt'
    options('2')
  elsif input['1'] || input['y'] || input['yes']
    puts 'You must be then'
    badass_boolean = input
    Log.new(badass_boolean).save
    second_question
  end
end

def first_question
  name = @name
  puts "How_iRoll"
  input = gets.chomp!
  save_answer(input)
  if input == 'opt'
    options('0')
  end
  input = gets.chomp!
  save_answer(input)
end

def second_question
  # ascii
  puts 'Where_iRoll'
  input = gets
  input.chomp!
end

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

#Helper methods and options________------------_________--------
def save_answer(type)
  valid_opts = ['1','bike','bicycle','2','Sun','Sunday driver','3','moto','motorcycle','4','skate','skateboard','5','hid','hidden']
  if valid_opts.include? type
    Log.new(type).save
    handle_answer(type)
  elsif
    options('10')
  end
end

def handle_answer(type)
  if type['1'] || type['bike'] || type['bicycle']
    bike_path
  elsif type['2'] || type['Sun'] || type['Sunday Driver']
    car_path
  elsif type['3'] || type['moto'] || type['motorcycle']
    motorcycle_path
  elsif type['4'] || type['skate'] || type['skateboard']
    skate_path
  elsif type['5'] || type['hid'] || type['hidden']
    options('0a')
  end
end

def options(num)
  # ascii
  if num == '0'
    puts <<EOS
Options:
1 or 'bike'  or 'bicycle'
2 or 'Sun'   or 'Sunday driver'
3 or 'moto'  or 'motorcycle'
4 or 'skate' or 'skateboard'
5 or 'hid'   or 'hidden options'
How_iRoll
EOS
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
elsif num == 'a'
    puts <<EOS
Options: ? Username?
Enter your unique username
EOS
  elsif num == '10'
    puts <<EOS
not a valid option... dummy
EOS
  end
end

# ascii
username?
