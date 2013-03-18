class Contact
  attr_reader :id
  def initialize(name,id=-1)
    @name = name
    @id = id
  end

  def save
     DB.execute("INSERT INTO contacts(name) VALUES ('#{@name}');")
     @id = DB.execute("SELECT last_insert_rowid();")[0][0]
  end

  def getData
     puts "Emails:"
     puts Email.getRecFrId(@id)
     puts "Addresses:"
     puts Addresses.getRecFrId(@id)
     puts "Phone numbers:"
     puts Number.getRecFrId(@id)
  end

  def self.getAll
    result = ""
    DB.execute("SELECT * FROM contacts;").map {|row| result+=row['id'].to_s+' '+row['name'].to_s+" \n"}
    result
  end

  def self.getFromId id
    cont = DB.execute("SELECT * FROM contacts WHERE id=#{id};")
    Contact.new(cont[0]['name'],cont[0]['id'])
  end
end