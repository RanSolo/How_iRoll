require_relative '../spec_helper'
# $LOAD_PATH << 'models'
describe 'Menu Integration' do
  let(:welcome_text) do
<<EOS
Welcome ransolo,

How_iRoll is a fun little app to help log your journies...
on wheels.  If you are walking or flying you can walk or
fly on to the next app buddy.

Ask yourself, ransolo, this first question...

How_iRoll
EOS
  end

  let(:main_menu_opts) do
<<EOS
Options:
1 or 'bike'  or 'bicycle'
2 or 'Sun'   or 'Sunday driver'
3 or 'moto'  or 'motorcycle'
4 or 'skate' or 'skateboard'
5 or 'hid'   or 'hidden options'
EOS
  end

  let (:main_menu_hid_opts) do
<<EOS
Options:
1 or 'JO'
2 or 'TH'
3 or 'GD'
4 or 'BA'
How_iRoll
EOS
  end
  let (:bike_opts) do
  <<EOS
Options:
1 or 'mtn' or 'mountain'
2 or 'st'  or 'street'
3 or 'hid' or 'hidden options'
EOS
  end
  let (:car_opts) do
<<EOS
Options:
1 or 'y' or 'yes'
2 or 'n'  or 'no'
3 or 'hid' or 'hidden options'
EOS
  end
  let (:moto_opts) do
<<EOS
Options: ? Cruiser or crotchrocket?
1 or 'cruiser'
2 or 'cr' or 'crotchrocket'
3 or 'hid' or 'hidden options'
EOS
end
#main menu ____________--------________-------
  context 'the menu displays after username is given' do
    let(:shell_output){run_H_iR_with_input('ransolo')}
    it 'should print the welcome_text' do
      shell_output.should include(welcome_text)
    end
  end

  context 'the user selects invalid option'  do
    let(:shell_output){run_H_iR_with_input('ransolo','z')}
    it 'should print out invalid option warning' do
      shell_output.should include('not a valid option... dummy')
    end
  end

  context "the user selects 'opt'" do
    let (:shell_output){run_H_iR_with_input('opt')}
    it 'should print available options' do
      shell_output.should include("Options: ? Username?\nEnter your unique username")
    end
  end

  context "the user selects 'hid' or 'hidden'" do
    let (:shell_output){run_H_iR_with_input('ransolo', 'hid')}
    it 'should print hidden options' do
      shell_output.should include(main_menu_hid_opts)
    end
  end
#bike_path________------------_____________------

  context 'the user selects bike_path options' do
    let (:shell_output){run_H_iR_with_input('ransolo', '1', 'opt')}
    it 'should print out bike options' do
      shell_output.should include(bike_opts)
    end
  end

  context 'the user selects bike_path' do
    let (:shell_output){run_H_iR_with_input('ransolo','1')}
    it 'should print out bike specific statement && question' do
      shell_output.should include("You must be so proud biking...\nlike a hamster on a wheel...\nmtn or st biking?")
    end
  end

  context 'the user selects mtn for bike specific question' do
    let (:shell_output){run_H_iR_with_input('ransolo', '1', 'mtn')}
    it 'should print statement and the second main question ' do
      shell_output.should include('Mountain biking is WAAAY cooler than street biking')
    end
  end

  context "the user selects car_path with 'Sun'" do
    let (:shell_output){run_H_iR_with_input('ransolo','Sun')}
    it 'should print car specific statement and question' do
      shell_output.should include('You must be rolling in it to have all that gas money.  Is your ride vintage?')
    end
  end

  context 'the user selects car_path options' do
    let (:shell_output){run_H_iR_with_input('ransolo','2', 'opt')}
    it 'should print out car options' do
      shell_output.should include("You must be rolling in it to have all that gas money.  Is your ride vintage?")
    end
  end

  context "the user selects car_path with '2'" do
    let (:shell_output){run_H_iR_with_input('ransolo','2')}
    it 'should print car specific options' do
      shell_output.should include('You must be rolling in it to have all that gas money.  Is your ride vintage?')
    end
  end

  context "the user selects car_path with 'Sunday driver'" do
    let (:shell_output){run_H_iR_with_input('ransolo','Sunday driver')}
    it 'should print car specific options' do
      shell_output.should include('You must be rolling in it to have all that gas money.  Is your ride vintage?')
    end
  end

  context "the user selects motorcycle_path with 'moto'" do
    let (:shell_output){run_H_iR_with_input('ransolo','moto')}
    it 'should print motorcycle specific options' do
      shell_output.should include("You must be a bad ass or something, you think you're tough or something?\nDon't aswer that tough guy/gal... answer this\n Cruiser or crotchrocket")
    end
  end

  context 'the user selects moto_path options' do
    let (:shell_output){run_H_iR_with_input('ransolo','3', 'opt')}
    it 'should print out bike options' do
      shell_output.should include(moto_opts)
    end
  end

  context "the user selects motorcycle_path with '3'" do
    let (:shell_output){run_H_iR_with_input('ransolo','3')}
    it 'should print motorcycle specific options' do
      shell_output.should include("You must be a bad ass or something, you think you're tough or something?")
    end
  end

  context "the user selects motorcycle_path with 'motorcycle'" do
    let (:shell_output){run_H_iR_with_input('ransolo','motorcycle')}
    it 'should print motorcycle specific options' do
      shell_output.should include("You must be a bad ass or something, you think you're tough or something?")
    end
  end

end
    # or enter new options by typing
    # 'enter'...  i.e. available options for our first question are: 'bike' or
    # 'bicycle'; 'sd' or 'Sunday driver'; skate or 'skateboard'; 'moto' or
    # 'motorcycle'; 'hid' or 'hidden options'.
