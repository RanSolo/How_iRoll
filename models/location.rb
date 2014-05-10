class Location
  attr_reader :errors
  attr_reader :id
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.all
    statement = "Select * from locations;"
    execute_and_instantiate(statement)
  end

  def self.count
    statement = "Select count(*) from locations;"
    result = Environment.database_connection.execute(statement)
    result[0][0]
  end

  def self.create(name)
    location = Location.new(name)
    location.save
    location
  end

  def self.find_by_name(name)
    statement = "select * from locations where name = ?;"
    execute_and_instantiate(statement, name)[0]
  end

  def self.last
    statement = "Select * from locations order by id DESC limit(1);"
    execute_and_instantiate(statement)[0]
  end

  def save
    if self.valid?
      statement = "Insert into locations (name) values (?);"
      Environment.database_connection.execute(statement, name)
      @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
      true
    else
      false
    end
  end

  def valid?
    @errors = []
    if !name.match /[a-zA-Z]/
      @errors << "'#{self.name}' is not a valid location name, as it does not include any letters."
    end
    if Location.find_by_name(self.name)
      @errors << "#{self.name} already exists."
    end
    @errors.empty?
  end

  private

  def self.execute_and_instantiate(statement, bind_vars = [])
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      location = Location.new(row['name'])
      location.instance_variable_set(:@id, row['id'])
      results << location
    end
    results
  end
end
