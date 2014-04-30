require_relative 'spec_helper'

describe 'Menu Integration' do
  let(:menu_text) do
<<EOS
How_iRoll is a fun little app to help log your journies... on wheels.
If you are walking or flying you can walk or fly on to the next app buddy.
At any time type "opt" for available options
Ask yourself this first question and use the options above to answer...

How_iRoll?
EOS
  end
  context "the menu displays on startup" do
    let(:shell_output){run_H_iR_with_input()}
    it "should print the menu" do
      shell_output.should include(menu_text)
    end
  end
end
    # or enter new options by typing
    # 'enter'...  i.e. available options for our first question are: 'bike' or
    # 'bicycle'; 'sd' or 'Sunday driver'; skate or 'skateboard'; 'moto' or
    # 'motorcycle'; 'hid' or 'hidden options'.
