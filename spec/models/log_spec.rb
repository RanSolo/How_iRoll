require_relative '../spec_helper'

describe Log do
  context '.all' do
    context 'with no logs in the database' do
      it 'should return an empty array' do
        Log.all.should == []
      end
    end
    context 'with multiple logs in the database' do
      let(:foo){ Log.new('Foo') }
      let(:bar){ Log.new('Bar') }
      let(:baz){ Log.new('Baz') }
      let(:grille){ Log.new('Grille') }
      before do
        foo.save
        bar.save
        baz.save
        grille.save
      end
      it 'should return all of the logs with their types and ids' do
        log_attrs = Log.all.map{ |log| [log.type, log.id] }
        log_attrs.should == [['Foo', foo.id],
                                ['Bar', bar.id],
                                ['Baz', baz.id],
                                ['Grille', grille.id]]
      end
    end
  end
  context '.count' do
    context 'with no logs in the database' do
      it 'should return 0' do
        Log.count.should == 0
      end
    end
    context 'with multiple logs in the database' do
      before do
        Log.new('Foo').save
        Log.new('Bar').save
        Log.new('Baz').save
        Log.new('Grille').save
      end
      it 'should return the correct count' do
        Log.count.should == 4
      end
    end
  end
  context '.find_by_name' do
    context 'with no logs in the database' do
      it 'should return 0' do
        Log.find_by_type('Foo').should be_nil
      end
    end
    context 'with log by that type in the database' do
      let(:foo){ Log.new('Foo') }
      before do
        foo.save
        Log.new('Bar').save
        Log.new('Baz').save
        Log.new('Grille').save
      end
      it 'should return the log with that type' do
        Log.find_by_type('Foo').type.should == 'Foo'
      end
      it 'should populate the id' do
        Log.find_by_type('Foo').id.should == foo.id
      end
    end
  end
  context '.last' do
    context 'with no logs in the database' do
      it 'should return nil' do
        Log.last.should be_nil
      end
    end
    context 'with multiple logs in the database' do
      let(:grille){ Log.new('Grille') }
      before do
        Log.new('Foo').save
        Log.new('Bar').save
        Log.new('Baz').save
        grille.save
      end
      it 'should return the last one inserted' do
        Log.last.type.should == 'Grille'
      end
      it 'should return the last one inserted with id populated' do
        Log.last.id.should == grille.id
      end
    end
  end
  context '#new' do
    let(:log){ Log.new('mountain biking') }
    it 'should store the type' do
      log.type.should == 'mountain biking'
    end
  end
  context '#create' do
    let(:result){ Environment.database_connection.execute('Select * from logs') }
    let(:log){ Log.create('foo') }
    context 'with a valid log' do
      before do
        Log.any_instance.stub(:valid?){ true }
        log
      end
      it 'should record the new id' do
        result[0]['id'].should == log.id
      end
      it 'should only save one row to the database' do
        result.count.should == 1
      end
      it 'should actually save it to the database' do
        result[0]['type'].should == 'foo'
      end
    end
    context 'with an invalid log' do
      before do
        Log.any_instance.stub(:valid?){ false }
        log
      end
      it 'should not save a new log' do
        result.count.should == 0
      end
    end
  end
  context '#save' do
    let(:result){ Environment.database_connection.execute('Select * from logs') }
    let(:log){ Log.new('foo') }
    context 'with a valid log' do
      before do
        log.stub(:valid?){ true }
      end
      it 'should only save one row to the database' do
        log.save
        result.count.should == 1
      end
      it 'should record the new id' do
        log.save
        log.id.should == result[0]['id']
      end
      it 'should actually save it to the database' do
        log.save
        result[0]['type'].should == 'foo'
      end
    end
    context 'with an invalid log' do
      before do
        log.stub(:valid?){ false }
      end
      it 'should not save a new log' do
        log.save
        result.count.should == 0
      end
    end
  end
  context '#valid?' do
    let(:result){ Environment.database_connection.execute("Select type from logs") }
    context 'after fixing the errors' do
      let(:log){ Log.new('123') }
      it 'should return true' do
        log.valid?.should be_false
        log.type = 'Bob'
        log.valid?.should be_true
      end
    end
    context 'with a unique type' do
      let(:log){ Log.new('impalement, 1/2 - 2 inches diameter') }
      it 'should return true' do
        log.valid?.should be_true
      end
    end
    context 'with a invalid type' do
      let(:log){ Log.new('420') }
      it 'should return false' do
        log.valid?.should be_false
      end
      it 'should save the error messages' do
        log.valid?
        log.errors.first.should == "'420' is not a valid log type, as it does not include any letters."
      end
    end
    context 'with a duplicate type' do
      let(:log){ Log.new('impalement, 1/2 inch diameter or smaller') }
      before do
        Log.new('impalement, 1/2 inch diameter or smaller').save
      end
      it "should return false" do
        log.valid?.should be_false
      end
      it "should save the error messages" do
        log.valid?
        log.errors.first.should == "impalement, 1/2 inch diameter or smaller already exists."
      end
    end
  end
end
