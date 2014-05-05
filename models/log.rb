class Log
  attr_reader :errors
  attr_reader :id
  attr_accessor :type

  def initialize(input)
    @type = type
    @errors = []
  end

  def self.count
     statement = "Select count(*) from logs"
     result = Environment.database_connection.execute(statement)
     result[0][0]
   end

   def self.find_by_type(type)
     statement = "select * from logs where name = '#{type}'"
     execute_and_instantiate(statement)
   end

   def self.last
     statement = "Select * from logs order by id DESC limit(1)"
     result = Environment.database_connection.execute(statement)
     unless result.empty?
       type  = result[0]["type"]
       Log.new(type)
     end
   end

   def save
     if Log.find_by_type(self.type)
       @errors << '#{self.name} already exists'
     statement = "Insert into log (type) values ('#{type }')"
     Environment.database_connection.execute(statement)
     true
   end
 end

   def self.execute_and_instantiate(statement)
     result = Environment.database_connection.execute(statement)
     unless result.empty?
       name = result[0]['type']
       Log.new(type)
     end
   end
 end

# The wheel in the sky keeps on turning...
# I don't know where Ill be tomorrow...
# The wheel in the sky keeps on turning...
# I don't know... I don't know... I don't...
# I do know...
# Journey sucks.
