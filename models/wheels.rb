class Wheels
  attr_reader :name

  def initialize(name)
  @name = name
  end

  def save
    statement = "insert into wheels"
    Environment.database_connection.execute(statment)
    true
  end

# The wheel in the sky keeps on turning...
# I don't know where Ill be tomorrow...
# The wheel in the sky keeps on turning...
# I don't know... I don't know... I don't...
# I do know...
# Journey sucks.

end
