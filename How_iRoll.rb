 #!/usr/bin/env ruby

$LOAD_PATH << 'lib'
$LOAD_PATH << 'models'

require 'environment'
Environment.environment = 'test'
$stderr = $stdout
# db = Environment.database_connection
# $Logger = Environment.logger

require 'log'

def welcome
  # $Logger.info "someone has run my program"
  puts <<EOS
How_iRoll is a fun little app to help log your journies... on wheels.
If you are walking or flying you can walk or fly on to the next app buddy.
At any time type "opt" for available options.
Ask yourself this first question...
Do you ever wonder...

EOS
  first_question
end

def bike_path
  puts "You must be so proud biking...\nlike a hamster on a wheel...\nmtn or st biking?"
  input = gets.chomp
  if input == 'opt'
    options('1')
  elsif input['1'] || input['mtn'] || input['mountain']
    puts 'Mountain biking is WAAAY cooler than street biking'
    sub_type = input
    Log.new(sub_type).save
    second_question
  elsif input['2'] || input['st'] || input['street']
    puts 'Cool... I guess'
    second_question
  end
end

def car_path
  puts 'You must be rolling in it to have all that gas money.  Is your ride vintage?'
  input = gets.chomp
  if input == 'opt'
    options('2')
  elsif input['2'] || input['y'] || input['yes']
    puts 'Classy'
    badass_boulioun = input
    Log.new(badass_boulioun).save
    second_question
  end
end

def motorcycle_path
  puts "You must be a bad ass or something, you think you're tough or something?"
  input = gets.chomp
  if input == 'opt'
    options('2')
  elsif input['1'] || input['y'] || input['yes']
    puts 'You must be then'
    badass_boulioun = input
    Log.new(badass_boulioun).save
    second_question
  end
end

def first_question
  puts 'How_iRoll'
  input = gets.chomp!
  if input == 'opt'
    options('0')
    handle_answer(input)
  elsif input['5'] || input['hid'] || input['hidden']
    options('0a')
  elsif input['1'] || input['bike'] || input['bicycle'] || input['2'] || input['Sun'] || input['Sunday Driver'] || input['3'] || input['moto'] || input['motorcycle'] || input['4'] || input['skate'] || input['skateboard']
    wheel_type = input
    Log.new(wheel_type).save
    handle_answer(wheel_type)
  elsif
    puts 'not a valid option... dummy'
    first_question
  end
end

def handle_answer(wheel_type)
  if wheel_type['1'] || wheel_type['bike'] || wheel_type['bicycle']
    bike_path
  elsif wheel_type['2'] || wheel_type['Sun'] || wheel_type['Sunday Driver']
    car_path
  elsif wheel_type['3'] || wheel_type['moto'] || wheel_type['motorcycle']
    motorcycle_path
  elsif wheel_type['4'] || wheel_type['skate'] || wheel_type['skateboard']
    skate_path
  end
end

def second_question
  puts 'Where_iRoll'
  input = gets
  input.chomp!
end

def options(num)
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
if self.respond_to? moto_path
  moto_path
elsif self.respond_to? car_path
  car_path
EOS

  end
end

welcome
