 #!/usr/bin/env ruby

$LOAD_PATH << "lib"
$LOAD_PATH << "models"

# require 'environment'
# Environment.environment = "test"

# require 'wheels'
def welcome
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
  puts <<EOS
You must be so proud biking...
like a hamster on a wheel...
mtn or st biking?
EOS
input = gets
input.chomp!
second_question
end

def car_path
  puts "You must be rolling in it to have all that gas money"
  input = gets
  input.chomp!
  second_question
end

def motorcycle_path
    puts "You must be a bad ass or something, you think you're tough or something?"
    input = gets
    input.chomp!
    second_question
end

def first_question
  puts "How_iRoll"
  input = gets
  input.chomp!
  handle_answer(input)
end

def handle_answer(input)
  if input == 'opt'
    options('0')
  elsif input['1'] || input['bike'] || input['bicycle']
    bike_path
  elsif input['2'] || input['Sun'] || input['Sunday Driver']
    car_path
  elsif input['3'] || input['moto'] || input['motorcycle']
    motorcycle_path
  elsif input['4'] || input['skate'] || input['skateboard']
    skate_path
  elsif input['5'] || input['hid'] || input['hidden']
    options('0a')
  elsif
  puts "not a valid option... dummy"
  first_question
end
end

def second_question
  puts "Where_iRoll"
  input = gets
  input.chomp!
end

def options(num)
  if num == '0'
    puts <<EOS
Options:
1 or 'bike'  or 'bicycle'
2 or 'sd'    or 'Sunday driver'
3 or 'moto'  or 'motorcycle'
4 or 'skate' or 'skateboard'
5 or 'hid'   or 'hidden options'
EOS
  end
  if num == '0a'
    puts <<EOS
Options:
1 or JO
2 or TH
3 or GD
4 or BA
EOS
  end
  first_question
end

welcome
