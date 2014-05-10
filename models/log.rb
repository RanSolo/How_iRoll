class Log
  def self.create_for(person, location, type, sub_type, travel_time, trip_time)
    statement = "Insert into logs (person_id, location_id, type, sub_type, travel_time, trip_time) values (?, ?, ?, ?, ?, ?);"
    Environment.database_connection.execute(statement, [person.id, location.id, type, sub_type, travel_time, trip_time])
  end

  def self.for(person, location)
    return if person.nil? or location.nil?
    statement = "Select type from logs where person_id = ? and location_id = ?"
    result = Environment.database_connection.execute(statement, [person.id, location.id])
    return nil if result.empty?
    ( result[0]["type"] == 1 )
  end
end
 # class Log
#   attr_reader :errors
#   attr_reader :id
#   attr_accessor :type
#
#   def initialize(type)
#     @type = type
#   end
#
#   def self.all
#     statement = "Select * from logs;"
#     execute_and_instantiate(statement)
#   end
#
#   def self.count
#     statement = "Select count(*) from logs;"
#     result = Environment.database_connection.execute(statement)
#     result[0][0]
#   end
#
#   def self.create(type)
#     log = Log.new(type)
#     log.save
#     log
#   end
#
#   def self.find_by_type(type)
#     statement = "select * from logs where type = ?;"
#     execute_and_instantiate(statement, type)[0]
#   end
#
#   def self.last
#     statement = "Select * from logs order by id DESC limit(1);"
#     execute_and_instantiate(statement)[0]
#   end
#
#   def save
#     if self.valid?
#       statement = "Insert into logs (type) values (?);"
#       Environment.database_connection.execute(statement, type)
#       @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
#       true
#     else
#       false
#     end
#   end
#
#   def valid?
#     @errors = []
#     if !type.match /[a-zA-Z]/
#       @errors << "'#{self.type}' is not a valid log type, as it does not include any letters."
#     end
#     if Log.find_by_type(self.type)
#       @errors << "#{self.type} already exists."
#     end
#     @errors.empty?
#   end
#
#   private
#
#   def self.execute_and_instantiate(statement, bind_vars = [])
#     rows = Environment.database_connection.execute(statement, bind_vars)
#     results = []
#     rows.each do |row|
#       log = Log.new(row['type'])
#       log.instance_variable_set(:@id, row['id'])
#       results << log
#     end
#     results
#   end
# end

# The wheel in the sky keeps on turning...
# I don't know where Ill be tomorrow...
# The wheel in the sky keeps on turning...
# I don't know... I don't know... I don't...
# I do know...
# Journey sucks.
