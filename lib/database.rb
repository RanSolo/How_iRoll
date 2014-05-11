require 'sqlite3'

class Database < SQLite3::Database
  def initialize(database)
    super(database)
      self.results_as_hash = true
    end

  def self.connection(environment)
    @connection ||= Database.new("db/How_iRoll_#{environment}.sqlite3")
  end

  def create_tables
    self.execute("CREATE TABLE logs (id INTEGER PRIMARY KEY AUTOINCREMENT, type varchar(50), person_id INTEGER, location_id INTEGER, date varchar(50), sub_type varchar(50), trip_time varchar(50), reason varchar(50))")
    self.execute("CREATE TABLE people (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50))")
    self.execute("CREATE TABLE locations (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50))")
  end

  def execute(statement, bind_vars = [])
    Environment.logger.info("Executing: #{statement} with: #{bind_vars}")
    super(statement, bind_vars)
  end
end
