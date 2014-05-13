require_relative '../spec_helper'

describe "Adding a person" do
  before do
    person = Person.new(name: "Billy Eckstein")
    person.save
  end
  context "adding a unique person" do
    let!(:output){ run_H_iR_with_input("ransolo") }
    it "should print a confirmation message" do
      output.should include("ransolo has been added")
       Person.count.should == 2
    end
    it "should insert a new person" do
      Person.count.should == 2
    end
    it "should use the name we entered" do
      Person.last.name.should == "ransolo"
    end
  end
  context "when a username that is being used is entered" do
    let(:output){ run_H_iR_with_input("Billy Eckstein") }
    it "should inquire about adding a new or viewing old logs" do
      output.should include("Welcome back Billy Eckstein\nWould you like to start a new log or view past logs")
    end
    it "shouldn't save the duplicate" do
      Person.count.should == 1
    end
  end
  context "entering an invalid looking person name" do
    context "with SQL injection" do
      let(:input){ "chattanooga'), ('425" }
      let!(:output){ run_H_iR_with_input(input) }
      it "should create the person without evaluating the SQL" do
        Person.last.name.should == input
      end
      it "shouldn't create an extra person" do
        Person.count.should == 2
      end
      it "should print a success message at the end" do
        output.should include("#{input} has been added")
      end
    end
  end
end
