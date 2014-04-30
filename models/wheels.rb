class Wheels
  attr_reader :name

  def initialize(name)
  @name = name
  end

  def save
    statement = "insert into wheels??"
    Environment.database_connection.execute(statment)
    true
  end


end
