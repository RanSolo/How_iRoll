require_relative 'helper'
require 'test/unit'

class TestMenuIntegration < MiniTest::Unit::TestCase

  def test_menu_prints_out
     shell_output = ""
     IO.popen('lib/how_iRoll.rb', 'r+') do |pipe|
       inputs.each do |input|
      # pipe.puts input
      pipe.close_write
      shell_output = pipe.read
    end
    expected_output = <<EOS
How_iRoll is a fun little app to help log your journies... on wheels.
If you're walking or flying you can walk or fly on to the next app buddy.
At any type "opt" for available options or enter new options by typing
'enter'...  i.e. available options for our first question are: 'bike' or
'bicycle'; 'sd' or 'Sunday driver'; skate or 'skateboard'; 'moto' or
'motorcycle'; 'hid' or 'hidden options'.

Ask yourself this first question and use the options above to answer...

How_iRoll?
EOS
    assert_equal expected_output, shell_output
  end
  end
end
