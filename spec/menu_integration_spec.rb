require_relative 'spec_helper'

describe 'Menu Integration' do
  let(:menu_text) do
<<EOS
How_iRoll is a fun little app to help log your journies... on wheels.
If you are walking or flying you can walk or fly on to the next app buddy.
At any time type "opt" for available options.
Ask yourself this first question...
Do you ever wonder...

How_iRoll
EOS
  end

  let(:opt1) do
<<EOS
Options:
1 or 'bike'  or 'bicycle'
2 or 'sd'    or 'Sunday driver'
3 or 'moto'  or 'motorcycle'
4 or 'skate' or 'skateboard'
5 or 'hid'   or 'hidden options'
EOS
  end
  let (:opt1a) do
<<EOS
Options:
1 or JO
2 or TH
3 or GD
4 or BA
EOS
  end

  context "the menu displays on startup" do
    let(:shell_output){run_H_iR_with_input()}
    it "should print the menu" do
      shell_output.should include(menu_text)
    end
  end

  context "the user selects invalid option"  do
    let(:shell_output){run_H_iR_with_input("z")}
    it "should print out invalid option warning" do
      shell_output.should include("not a valid option... dummy")
    end
  end

  context "the user selects 'opt'" do
    let (:shell_output){run_H_iR_with_input("opt")}
    it "should print available options" do
      shell_output.should include(opt1)
    end
  end

  context "the user selects 'hid' or 'hidden'" do
    let (:shell_output){run_H_iR_with_input("hid")}
    it "should print hidden options" do
      shell_output.should include(opt1a)
    end
  end

  context "the user selects bike_path" do
    let (:shell_output){run_H_iR_with_input("1")}
    it "should print out bike specific statement && question" do
      shell_output.should include("You must be so proud biking...\nlike a hamster on a wheel...\nmtn or st biking?")
    end
  end

  context "the user selects car_path with 'Sun'" do
    let (:shell_output){run_H_iR_with_input("Sun")}
    it "should print car specific statement and question" do
      shell_output.should include("You must be rolling in it to have all that gas money")
    end
  end

  context "the user selects car_path with '2'" do
    let (:shell_output){run_H_iR_with_input("2")}
    it "should print car specific options" do
      shell_output.should include("You must be rolling in it to have all that gas money")
    end
  end

  context "the user selects car_path with 'Sunday driver'" do
    let (:shell_output){run_H_iR_with_input("Sunday driver")}
    it "should print car specific options" do
      shell_output.should include("You must be rolling in it to have all that gas money")
    end
  end

  context "the user selects motorcycle_path with 'moto'" do
    let (:shell_output){run_H_iR_with_input("moto")}
    it "should print motorcycle specific options" do
      shell_output.should include("You must be a bad ass or something, you think your tough or something?")
    end
  end

  context "the user selects motorcycle_path with '3'" do
    let (:shell_output){run_H_iR_with_input("3")}
    it "should print motorcycle specific options" do
      shell_output.should include("You must be a bad ass or something, you think your tough or something?")
    end
  end

  context "the user selects motorcycle_path with 'motorcycle'" do
    let (:shell_output){run_H_iR_with_input("motorcycle")}
    it "should print motorcycle specific options" do
      shell_output.should include("You must be a bad ass or something, you think you're tough or something?")
    end
  end

end
    # or enter new options by typing
    # 'enter'...  i.e. available options for our first question are: 'bike' or
    # 'bicycle'; 'sd' or 'Sunday driver'; skate or 'skateboard'; 'moto' or
    # 'motorcycle'; 'hid' or 'hidden options'.
