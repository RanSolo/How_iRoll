class Log

  def self.create_for(person_id, location_id, date, type, sub_type, trip_time, reason)
    statement = "Insert into logs (person_id, location_id, date, type, sub_type, trip_time, reason) values (?, ?, ?, ?, ?, ?, ?);"
    Environment.database_connection.execute(statement, [person_id, location_id, date, type, sub_type, trip_time, reason])
    @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
    true
  end


  def self.for(person_id, location_id)
    return if person_id.nil? or location_id.nil?
    statement = "Select * from logs where person_id = ? and location_id = ?"
    result = Environment.database_connection.execute(statement, [person_id, location_id])
    return nil if result.empty?
    ( result[0]["name"] == 1 )
  end

  def self.all(person_id)
    return if person_id.nil?
    statement = "Select * from logs where person_id = ?"
    result = Environment.database_connection.execute(statement, [person_id])
    return nil if result.empty?
    result.each {|log| print "On #{log['date']} you took a #{log['type']} trip\n"}
  end

  # def self.find_location_name(location_id)
  #   return if
end

# The wheel in the sky keeps on turning...
# I don't know where Ill be tomorrow...
# The wheel in the sky keeps on turning...
# I don't know... I don't know... I don't...
# I do know...
# Journey sucks.
