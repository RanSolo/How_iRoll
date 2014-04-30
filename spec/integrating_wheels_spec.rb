# require_relative 'spec_helper'
#
# describe "Adding your wheels" do
#   context "adding a unique set of wheels"
#     before do
#       wheels = wheels.new('unicycle')
#       wheels.save
#     end
#     let(:output){run_H_iR_with_input("unicycle")}
#     it "should print a confirmation message" do
#       output.should include("unicycle has been added.")
#   end
#   it "should insert a new set of wheels" do
#     Wheels.count.should == 2
#   end
#   it "should use the name we entered" do
#     Wheels.last.name.should == "unicycle"
#   end
# end
