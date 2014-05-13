class Log < ActiveRecord::Base

  def self.create_for(person, location, date, type, sub_type, trip_time, reason)
    Log.create(person_id: person.id, location_id: location.id)
  end


  def self.for(person, location)
    return if person.nil? or location.nil?
    log = Log.where(person_id: person.id, location_id: location.id).first
    return nil unless log
  end

  # def self.(person_id)
  #   Log.where(person_id: person_id).all
  # end
end
# result.each {|log| print "On #{log['date']} you took a #{log['type']} trip\n"}

# The wheel in the sky keeps on turning...
# I don't know where Ill be tomorrow...
# The wheel in the sky keeps on turning...
# I don't know... I don't know... I don't...
# I do know...
# Journey sucks.
