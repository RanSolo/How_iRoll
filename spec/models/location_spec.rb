require_relative '../spec_helper'

describe Location do
  context '.all' do
    context 'with no locations in the database' do
      it 'should return an empty array' do
        Location.all.should == []
      end
    end
    context 'with multiple locations in the database' do
      let(:foo){ Location.new(name: 'Foo') }
      let(:bar){ Location.new(name: 'Bar') }
      let(:baz){ Location.new(name: 'Baz') }
      let(:grille){ Location.new(name: 'Grille') }
      before do
        foo.save
        bar.save
        baz.save
        grille.save
      end
      it 'should return all of the locations with their types and ids' do
        log_attrs = Location.all.map{ |location| [location.name, location.id] }
        log_attrs.should == [['Foo', foo.id],
                                ['Bar', bar.id],
                                ['Baz', baz.id],
                                ['Grille', grille.id]]
      end
    end
  end
  context '.count' do
    context 'with no locations in the database' do
      it 'should return 0' do
        Location.count.should == 0
      end
    end
    context 'with multiple locations in the database' do
      before do
        Location.new(name: 'Foo').save
        Location.new(name: 'Bar').save
        Location.new(name: 'Baz').save
        Location.new(name: 'Grille').save
      end
      it 'should return the correct count' do
        Location.count.should == 4
      end
    end
  end
  context '.find_by_name' do
    context 'with no locations in the database' do
      it 'should return 0' do
        Location.find_by_name('Foo').should be_nil
      end
    end
    context 'with location by that name in the database' do
      let(:foo){ Location.new(name: 'Foo') }
      before do
        foo.save
        Location.new(name: 'Bar').save
        Location.new(name: 'Baz').save
        Location.new(name: 'Grille').save
      end
      it 'should return the location with that name' do
        Location.find_by_name('Foo').name.should == 'Foo'
      end
      it 'should populate the id' do
        Location.find_by_name('Foo').id.should == foo.id
      end
    end
  end
  context '.last' do
    context 'with no locations in the database' do
      it 'should return nil' do
        Location.last.should be_nil
      end
    end
    context 'with multiple locations in the database' do
      let(:grille){ Location.new(name: 'Grille') }
      before do
        Location.new(name: 'Foo').save
        Location.new(name: 'Bar').save
        Location.new(name: 'Baz').save
        grille.save
      end
      it 'should return the last one inserted' do
        Location.last.name.should == 'Grille'
      end
      it 'should return the last one inserted with id populated' do
        Location.last.id.should == grille.id
      end
    end
  end
  context '#new' do
    let(:location){ Location.new(name: 'Chattanooga') }
    it 'should store the name' do
      location.name.should == 'Chattanooga'
    end
  end
  context '#create' do
    let(:result){ Location.connection.execute("Select * from locations") }
    let(:location){ Location.create(name: 'foo') }
    context 'with a valid location' do
      before do
        Location.any_instance.stub(:valid?){ true }
        location
      end
      it 'should record the new id' do
        result[0]['id'].should == location.id
      end
      it 'should only save one row to the database' do
        result.count.should == 1
      end
      it 'should actually save it to the database' do
        result[0]['name'].should == 'foo'
      end
    end
    context 'with an invalid location' do
      before do
        Location.any_instance.stub(:valid?){ false }
        location
      end
      it 'should not save a new location' do
        result.count.should == 0
      end
    end
  end
  context '#save' do
    let(:result){ Location.connection.execute("Select * from locations") }
    let(:location){ Location.new(name: "foo") }
    context 'with a valid location' do
      before do
        location.stub(:valid?){ true }
      end
      it 'should only save one row to the database' do
        location.save
        result.count.should == 1
      end
      it 'should record the new id' do
        location.save
        location.id.should == result[0]['id']
      end
      it 'should actually save it to the database' do
        location.save
        result[0]['name'].should == 'foo'
      end
    end
    context 'with an invalid location' do
      before do
        location.stub(:valid?){ false }
      end
      it 'should not save a new location' do
        location.save
        result.count.should == 0
      end
    end
  end
  context '#valid?' do
    let(:result){ Location.connection.execute("Select name from locations") }
    context 'after fixing the errors' do
      let(:location){ Location.new(name: '123') }
      it 'should return true' do
        location.valid?.should be_false
        location.name = 'Chattanooga'
        location.valid?.should be_true
      end
    end
    context 'with a unique name' do
      let(:location){ Location.new(name: 'Chattanooga') }
      it 'should return true' do
        location.valid?.should be_true
      end
    end
    context 'with a invalid name' do
      let(:location){ Location.new(name: '420') }
      it 'should return false' do
        location.valid?.should be_false
      end
      it 'should save the error messages' do
        location.valid?
        location.errors[:name].first.should == "is not a valid location name, as it does not include any letters."
      end
    end
    context 'with a duplicate name' do
      let(:location){ Location.new(name: 'Chattanooga') }
      before do
        Location.new(name: 'Chattanooga').save
      end
      it "should return false" do
        location.valid?.should be_false
      end
      it "should save the error messages" do
        location.valid?
        location.errors[:name].first.should == "already exists."
      end
    end
  end
end
