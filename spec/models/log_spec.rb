require_relative '../spec_helper'

describe Log do
  context "#create_for" do
    let(:result){ Environment.database_connection.execute("Select * from logs") }
    let(:person){ Person.new("Ransolo") }
    let(:location){ Location.new("Chattanooga") }
    before do
      person.save
      location.save
      Log.create_for(person.id, location.id, '3-12-13', 'bike', 'mtn', '1 hour', 'big pimpin')
    end
    it "should save a new log to the database" do
      result.count.should == 1
    end
    it "should save the foreign key for person" do
      result[0]["person_id"].should == person.id
    end
    it "should save the foreign key for location" do
      result[0]["location_id"].should == location.id
    end
  end

  describe "#for" do
    let(:person1){ Person.create("Bob") }
    let(:person2){ Person.create("Julie") }
    let(:location1){ Location.create("Chattanooga") }
    let(:location2){ Location.create("Nashville") }
    before do
      person1.save
      person2.save
      location1.save
      location2.save

      Log.create_for(person1.id, location1.id, '3-12-13', 'bike', 'mtn', '1 hour', 'big pimpin')
      Log.create_for(person2.id,  location1.id, '3-12-13', 'bike', 'mtn', '1 hour', 'big pimpin')
      Log.create_for(person1.id, location1.id, '3-12-13', 'bike', 'mtn', '1 hour', 'big pimpin')
    end

    context "if location is nil" do
      let(:result){ Log.for(person1.id, nil) }
      it { result.should be_nil }
    end

    context "if person is nil" do
      let(:result){ Log.for(nil, location1.id) }
      it { result.should be_nil }
    end

    context "if the person and location don't correspond" do
      let(:result){ Log.for(person2.id, location2.id) }
      it { result.should be_nil }
    end
  end
end
