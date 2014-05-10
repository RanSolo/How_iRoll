#   require_relative '../spec_helper'
#
#   describe "Adding a log" do
#     before do
#       log = Log.new("bike_path")
#       log.save
#     end
#     context "adding a unique log" do
#       let!(:output){ run_H_iR_with_input("ransolo", "2") }
#       it "should print a confirmation message" do
#         output.should include("A Sunday driver log has been added")
#         Log.count.should == 2
#       end
#     it "should insert a new log" do
#       Log.count.should == 2
#     end
#     it "should use the name we entered" do
#       Log.last.type.should == "Sunday driver"
#     end
#   end
# #   context "adding a duplicate log" do
#     let(:output){ run_H_iR_with_input("2", "Decapitation") }
#     it "should print an error message" do
#       output.should include("Decapitation already exists.")
#     end
#     it "should ask them to try again" do
#       menu_text = "What is the log you want to add?"
#       output.should include_in_order(menu_text, "already exists", menu_text)
#     end
#     it "shouldn't save the duplicate" do
#       Log.count.should == 1
#     end
#     context "and trying again" do
#       let!(:output){ run_H_iR_with_input("2", "Decapitation", "Leprosy") }
#       it "should save a unique item" do
#         Log.last.name.should == "Leprosy"
#       end
#       it "should print a success message at the end" do
#         output.should include("Leprosy has been added")
#       end
#     end
#   end
#   context "entering an invalid looking log name" do
#     context "with SQL injection" do
#       let(:input){ "phalangectomy'), ('425" }
#       let!(:output){ run_H_iR_with_input("2", input) }
#       it "should create the log without evaluating the SQL" do
#         Log.last.name.should == input
#       end
#       it "shouldn't create an extra log" do
#         Log.count.should == 2
#       end
#       it "should print a success message at the end" do
#         output.should include("#{input} has been added")
#       end
#     end
#     context "without alphabet characters" do
#       let(:output){ run_H_iR_with_input("2", "4*25") }
#       it "should not save the log" do
#         Log.count.should == 1
#       end
#       it "should print an error message" do
#         output.should include("'4*25' is not a valid log name, as it does not include any letters.")
#       end
#       it "should let them try again" do
#         menu_text = "What is the log you want to add?"
#         output.should include_in_order(menu_text, "not a valid", menu_text)
#       end
#     end
#   end
# end
