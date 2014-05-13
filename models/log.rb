class Log < ActiveRecord::Base

  belongs_to :location
  belongs_to :person


  scope :for, ->(location){where(location: location)}
  # def self.(person_id)
  #   Log.where(person_id: person_id).all
  # end
end
# result.each {|log| print "On #{log['date']} you took a #{log['category']} trip\n"}

# The wheel in the sky keeps on turning...
# I don't know where Ill be tomorrow...
# The wheel in the sky keeps on turning...
# I don't know... I don't know... I don't...
# I do know...
# Journey sucks.
