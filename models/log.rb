class Log
  attr_reader :type

  def initialize(type)
  @type = type
  end

  def save
    if Wheels.find_by_type(self.type)
      @errors << "#{self.type} already exists."
      $Logger.info "there was a problem saving#{@type}"
      false
    else
      statement = "insert into wheels (type) values (?);"
      Environment.database_connection.execute(statment, name)
      true
    end
  end


# The wheel in the sky keeps on turning...
# I don't know where Ill be tomorrow...
# The wheel in the sky keeps on turning...
# I don't know... I don't know... I don't...
# I do know...
# Journey sucks.

end
