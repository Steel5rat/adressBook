class Contact
  attr_reader :id
  def initialize name
    @name = name
  end

  def save
     DB.execute("INSERT INTO contacts(name) VALUES ('#{@name}');")
     puts @id = DB.execute("SELECT last_insert_rowid();")[0][0]
  end
end